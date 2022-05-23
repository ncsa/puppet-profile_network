# @summary Mellanox configuration
#
# @example
#   include profile_network::mellanox
class profile_network::mellanox {
  include ::profile_network::mellanox::nic_cable_health
}
