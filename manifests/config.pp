# = Class: alfresco::config
#
# Handles the configuration of Alfresco.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::config {

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
