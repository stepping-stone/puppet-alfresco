# = Class: alfresco::config
#
# Handles the configuration of Alfresco.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::config {

  File {
    require => Class['alfresco::install'],
  }

  case $::osfamily {
    debian: {
      file { "alfresco-global.properties":
        path => "${alfresco_dir}/tomcat/shared/classes/alfresco-global.properties",
        content => template("alfresco/alfresco-global.properties.erb"),
      }

      file { "${alfresco_dir}/tomcat/shared/classes/alfresco":
        ensure => directory,
        owner => $user,
        group => $group,
        mode => 0755,
      }

      file { "${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension":
        ensure => directory,
        owner => $user,
        group => $group,
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
      file { 'alfresco-global.properties':
        path    => '/etc/alfresco-4.2/classes/alfresco-global.properties',
        content => template("alfresco/alfresco-global.properties.erb"),
        owner => $user,
	group => $group,
	mode  => 0640,
      }

      file { 'alfresco.xml':
        path    => '/etc/alfresco-4.2/Catalina/localhost/alfresco.xml',
        content => template("alfresco/alfresco.erb"),
        owner => $user,
	group => $group,
	mode  => 0640,
      }
      file { 'server.xml':
        path    => '/etc/alfresco-4.2/server.xml',
        content => template("alfresco/server.erb"),
        owner => $user,
	group => $group,
	mode  => 0640,
      }
      file { 'alfresco-4.2':
        path    => '/etc/init.d/alfresco-4.2',
	content => template("alfresco/alfresco-4.2.erb"),
	owner   => 'root',
	group   => 'root',
	mode    => 0755,
      }
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
