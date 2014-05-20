# = Class: alfresco::gentoo
#
# Gentoo-specific installation
#
#

class alfresco::gentoo {
  portage::package { 'www-apps/alfresco-bin':
    ensure   => present,
    keywords => ['~amd64'],
  }
}
