# @summary Configure Link Layer Discovery Protocol (LLDP)
#
# lldpad is a Linux daemon that implements the Link Layer Discovery Protocol (LLDP)
# and Data Center Bridging capabilities exchange protocol (DCBX) on supported network
# interfaces, allowing devices to advertise information about themselves to directly
# connected peers. 
#
# @param enabled
#   Boolean to define if this lldp class is enabled
#
# @param packages
#   Packages to install 
#
# @param services
#   Services to manage
#
# @example
#   include profile_network::lldp
class profile_network::lldp (
  Boolean $enabled,
  Hash    $packages,
  Hash    $services,
) {
  # ONLY SETUP If enabled
  if ( $enabled ) {
    ensure_resources('package', $packages )

    # ENABLE LLDP $services
    ensure_resources('service', $services )
  }
}
