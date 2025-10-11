# @summary Configure support for RoCE v2
#
# RoCEv2, or RDMA over Converged Ethernet version 2, is a network protocol that
# utilizes Remote Direct Memory Access (RDMA) capabilities to enable low-latency,
# high-throughput data transfers over Ethernet networks, specifically using UDP
# encapsulation.
#
# @param enabled
#   Boolean to define if this roce class is enabled
#
# @param env_vars
#   Key value pairs of environment variables to set
#
# @param firewall_cidrs
#   List of subnet CIDRs that RoCE v2 data transfer allowed from
#
# @param firewall_port
#   Port that RoCE v2 data transfer allowed to access
#
# @param firewall_proto
#   Network protocol of port used for RoCE v2 data transfer
#
# @param packages
#   Packages to install 
# 
# @example
#   include profile_network::roce
class profile_network::roce (
  Boolean $enabled,
  Hash    $env_vars,
  Array   $firewall_cidrs,
  String  $firewall_port,
  String  $firewall_proto,
  Hash    $packages,
) {
  # ONLY SETUP If enabled
  if ( $enabled ) {
    include profile_network::lldp

    ensure_resources('package', $packages )

    $firewall_cidrs.each | String $cidr | {
      firewall { "800 profile_network::roce - RoCE v2 data transfer access from '${cidr}'" :
        proto  => $firewall_proto,
        dport  => $firewall_port,
        action => 'accept',
        source => $cidr,
      }
    }

    file { '/etc/profile.d/roce_env.sh':
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template("${module_name}/roce_env.sh.erb"),
    }

    # future: configure rdma_cm & rdma_ucm
  }
}
