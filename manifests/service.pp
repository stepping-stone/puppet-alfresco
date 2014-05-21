# = Class: alfresco::service
#
# Handles the Alfresco service.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::service {

  service { 'alfresco-4.2':
    ensure => running,
    enable => true,
    require => Class['alfresco::config'],
  }

}
