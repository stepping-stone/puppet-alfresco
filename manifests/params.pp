# = Class: alfresco::params
#
# Contains default values for Alfresco.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::params {
  case $::osfamily {
    debian: {
    }
    gentoo: {
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }
}
