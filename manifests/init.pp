# @summary Configure networking
#
# @example
#   include profile_network
class profile_network {
  if $facts['has_mellanox'] {
    include ::profile_network::mellanox
  }
}
