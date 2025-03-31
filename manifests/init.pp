# @summary Configure networking
#
# @example
#   include profile_network
class profile_network {
  include profile_network::benchmark
  include profile_network::lldp
  if $facts['has_mellanox'] {
    include profile_network::mellanox
  }
  include profile_network::roce
}
