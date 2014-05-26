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
      File {
        owner => $user,
	group => $group,
	mode  => 0640,
      }

      file { 'alfresco-global.properties':
        path    => '/etc/alfresco-4.2/classes/alfresco-global.properties',
        content => template("alfresco/alfresco-global.properties.erb"),
      }

      file { 'alfresco.xml':
        path    => '/etc/alfresco-4.2/Catalina/localhost/alfresco.xml',
        content => template("alfresco/alfresco.erb"),
      }
      file { 'server.xml':
        path    => '/etc/alfresco-4.2/server.xml',
        content => template("alfresco/server.erb"),
      }
      exec { 'replace-init':
        command => "/bin/sed -i -e 's|exec \${JAVA_HOME}/bin/\${cmd}|exec /usr/bin/authbind|' -e ':a;N;$!ba;s|\${JAVA_OPTS} \\\\n.*\${args}|--deep \${JAVA_HOME}/bin/\${cmd} \${JAVA_OPTS} \\\\\ \n \${args}|' /etc/init.d/alfresco-4.2",
        user => 'root',
      }
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
