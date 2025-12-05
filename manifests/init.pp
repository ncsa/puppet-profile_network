# @summary Configure networking
#
# @param required_pkgs
#   Base packages required for this module
#
# @example
#   include profile_network
class profile_network (
  Hash    $required_pkgs,
) {
  ensure_resources('package', $required_pkgs )

  include profile_network::benchmark
  include profile_network::lldp
  if $facts['has_mellanox'] {
    include profile_network::mellanox
  }
  include profile_network::roce
}
