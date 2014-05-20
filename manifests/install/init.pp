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
