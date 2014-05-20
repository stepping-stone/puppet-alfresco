class alfresco::gentoo {
  portage::package { 'www-apps/alfresco-bin':
    ensure => present,
  }
}
