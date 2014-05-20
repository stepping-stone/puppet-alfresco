# = Class: alfresco::install::gentoo
#
# Gentoo-specific installation.
#

class alfresco::install::gentoo {
  portage::package { 'www-apps/alfresco-bin':
    ensure   => present,
    keywords => ['~amd64'],
  }
}
