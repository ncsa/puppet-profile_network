# @summary Mellanox health
#
# Configs Telegraf script that monitors Mellanox port and cable health
#
# @param enabled
#   Enable or disable this health check
#
# @param telegraf_cfg
#   Hash of key:value pairs passed to telegraf::input as options
#
# @example
#   include profile_network::mellanox::nic_cable_health
class profile_network::mellanox::nic_cable_health (
  Boolean $enabled,
  Hash    $telegraf_cfg,
){

  #
  # Templatized telegraf script
  #
  $script_base_name = 'mellanox_nic_cable_health'
  $script_path = '/etc/telegraf/scripts/mellanox'
  $script_extension = '.sh'
  $script_full_path = "${script_path}/${script_base_name}${script_extension}"

  include profile_monitoring::telegraf
  include ::telegraf

  if ($enabled) and ($::profile_monitoring::telegraf::enabled) {
    $ensure_parm = 'present'
  } else {
    $ensure_parm = 'absent'
  }

  # Create folder for telegraf scripts
  $script_dir_defaults = {
    ensure => 'directory',
    owner  => 'root',
    group  => 'telegraf',
    mode   => '0750',
  }
  ensure_resource('file', $script_path , $script_dir_defaults)

  # Setup telegraf config
  $telegraf_cfg_final = $telegraf_cfg + { 'command' => $script_full_path }
  telegraf::input { $script_base_name :
    ensure      => $ensure_parm,
    plugin_type => 'exec',
    options     => [ $telegraf_cfg_final ],
    require     => File[$script_full_path],
  }

  # Setup the actual script
  file { $script_full_path :
    ensure  => $ensure_parm,
    content => file("${module_name}/${script_base_name}${script_extension}"),
    mode    => '0750',
    owner   => 'root',
    group   => 'telegraf',
  }
}
