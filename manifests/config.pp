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
      # the configuration files
      file { "alfresco-global.properties":
        path => "${alfresco_dir}/tomcat/shared/classes/alfresco-global.properties",
        content => template("alfresco/alfresco-global.properties.erb"),
      }

      file { "${alfresco_dir}/tomcat/shared/classes/alfresco":
        ensure => directory,
        owner => $user,
        group => $user,
        mode => 0755,
      }

      file { "${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension":
        ensure => directory,
        owner => $user,
        group => $user,
        mode => 0755,
        require => File["${alfresco_dir}/tomcat/shared/classes/alfresco"],
      }

      file { "share-config-custom.xml":
        path => "${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml",
        content => template("alfresco/share-config-custom.xml.erb"),
        require => File["${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension"],
      }
    }
    gentoo: {
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
