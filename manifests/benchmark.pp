# @summary Configure networking benchmarking and testing tools
#
# @param enabled
#   Boolean to define if this benchmark class is enabled
#
# @param firewall_cidrs
#   List of subnet CIDRs that benchmark testing allowed from
#
# @param firewall_port
#   Port that benchmark testing allowed to
#
# @param firewall_proto
#   Network protocol of port used for benchmark testing
#
# @param packages
#   Packages to install 
# 
# @example
#   include profile_network::benchmark
class profile_network::benchmark (
  Boolean $enabled,
  Array   $firewall_cidrs,
  String  $firewall_port,
  String  $firewall_proto,
  Hash    $packages,
) {
  # ONLY SETUP If enabled
  if ( $enabled ) {
    ensure_resources('package', $packages )

    $firewall_cidrs.each | String $cidr | {
      firewall { "800 profile_network::benchmark - network benchmarking access from '${cidr}'" :
        proto  => $firewall_proto,
        dport  => $firewall_port,
        action => 'accept',
        source => $cidr,
      }
  } }
}
