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
        path => "${alfresco::alfresco_dir}/tomcat/shared/classes/alfresco-global.properties",
        content => template("alfresco/alfresco-global.properties.erb"),
      }

      file { "${alfresco::alfresco_dir}/tomcat/shared/classes/alfresco":
        ensure => directory,
        owner => $alfresco::user,
        group => $alfresco::group,
        mode => 0755,
      }

      file { "${alfresco::alfresco_dir}/tomcat/shared/classes/alfresco/web-extension":
        ensure => directory,
        owner => $alfresco::user,
        group => $alfresco::group,
        mode => 0755,
        require => File["${alfresco::alfresco_dir}/tomcat/shared/classes/alfresco"],
      }

      file { "share-config-custom.xml":
        path => "${alfresco::alfresco_dir}/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml",
        content => template("alfresco/share-config-custom.xml.erb"),
        require => File["${alfresco::alfresco_dir}/tomcat/shared/classes/alfresco/web-extension"],
      }
    }
    gentoo: {
      File {
        owner => $alfresco::user,
        group => $alfresco::group,
        mode  => 0640,
      }
      file { 'alfresco-global.properties':
        ensure  => file,
        path    => "${::alfresco::alfresco_dir}/classes/alfresco-global.properties",
        content => template("alfresco/alfresco-global.properties.erb"),
      }
      file { 'alfresco.xml':
        ensure  => file,
        path    => "$alfresco::alfressco_dir/Catalina/localhost/alfresco.xml",
        content => template("alfresco/alfresco.erb"),
      }
      file { 'server.xml':
        ensure  => file,
        path    => "$alfresco::alfresco_dir/server.xml",
        content => template("alfresco/server.erb"),
      }
      file { 'alfresco-4.2':
        ensure  => file,
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
