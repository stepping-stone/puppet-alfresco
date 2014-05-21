# = Class: alfresco::install
#
# Handles the installation of Alfresco.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::install {

  case $::osfamily {
    debian: {
      class { 'alfresco::install::debian':
      }
    }
    gentoo: {
      class { 'alfresco::install::gentoo':
      }
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
