# = Class: alfresco::install::debian
#
# Debian-specific installation.
#

class alfresco::install::debian {

  $zip = "alfresco-community-${version}.zip"
  $download_url = "http://dl.alfresco.com/release/community/build-${build}/${zip}"
  $alfresco_dir = "${webapp_base}/${user}"
  $alfresco_home = "${alfresco_dir}/alfresco-home"
  
  $share_webapp_context = $share_contextroot ? {
    '/' => 'share',	
    '' => 'share',
    default => "${share_contextroot}"
  }
      
  $share_webapp_war = $share_contextroot ? {
    '' => "share.war",
    '/' => "share.war",
    default => "${share_contextroot}.war"	
  }
  
  $alfresco_webapp_context = $alfresco_contextroot ? {
    '/' => 'alfresco',	
    '' => 'alfresco',
    default => "${alfresco_contextroot}"
  }
      
  $alfresco_webapp_war = $alfresco_contextroot ? {
    '' => "alfresco.war",
    '/' => "alfresco.war",
    default => "${alfresco_contextroot}.war"	
  }
  # required packages
  if (!defined(Package['unzip'])) {
    package { "unzip":
      ensure => present,
    }	
  }
  
  package { "python-software-properties":
    ensure => present,
  }
  
  exec { "apt-update-swftools":
    command => "/usr/bin/aptitude update",
    refreshonly => true,
  }
  
  exec { "add-apt-repository-swftools":
    command => "/usr/bin/add-apt-repository ppa:guilhem-fr/swftools",
    notify => Exec["apt-update-swftools"],
    require => Package["python-software-properties"],
  }
  
  package { "imagemagick":
    ensure => latest,
  }
  
  package { "swftools":
    ensure => latest,
    require => Exec["apt-update-swftools"],
  }
  
  package { "libreoffice":
    ensure => latest,
  }
  # download and extract alfresco
  file { $alfresco_home:
    ensure => directory,
    mode => 0755,
    owner => $user,
    group => $user,
    require => Tomcat::Webapp::User[$user],
  }
  
  exec { "download-alfresco":
    command => "/usr/bin/wget -O /tmp/${zip} ${download_url}",
    creates => "/tmp/${zip}",
    timeout => 1200,	
  }
  
  file { "/tmp/${zip}":
    ensure => file,
    require => Exec["download-alfresco"],
  }
  
  exec { "extract-alfresco" :
    command => "/usr/bin/unzip ${zip} -d /tmp/alfresco-${version}",
    creates => "/tmp/alfresco-${version}/web-server/webapps/alfresco.war",
    require => [
      File["/tmp/${zip}"],
      Package["unzip"]
    ],
    notify => [
      Exec['move-alfresco-war'],
      Exec['move-share-war']
    ],
    cwd => "/tmp",
    user => "root"
  }
  
  exec { "move-alfresco-war":
    command => "/bin/mv /tmp/alfresco-${version}/web-server/webapps/alfresco.war ${alfresco_dir}/tomcat/webapps/${alfresco_webapp_war}",
    refreshonly => true,
    user => "root",
    require => [
      Exec["extract-alfresco"],
      Tomcat::Webapp::Tomcat[$user]
    ]
  }
  
  file { "alfresco-war":
    ensure => file,
    path => "${alfresco_dir}/tomcat/webapps/${alfresco_webapp_war}",
    owner => $user,
    group => $user,
    mode => 0644,
    require => Exec["move-alfresco-war"],
  }
  
  exec { "move-share-war":
    command => "/bin/mv /tmp/alfresco-${version}/web-server/webapps/share.war ${alfresco_dir}/tomcat/webapps/${share_webapp_war}",
    refreshonly => true,
    user => "root",
    require => [
      Exec["extract-alfresco"],
      Tomcat::Webapp::Tomcat[$user]
    ]
  }
  
  file { "share-war":
    ensure => file,
    path => "${alfresco_dir}/tomcat/webapps/${share_webapp_war}",
    owner => $user,
    group => $user,
    mode => 0644,
    require => Exec["move-share-war"],
  }
  
  exec { "move-alfresco-licences":
    command => "/bin/mv /tmp/alfresco-${version}/licenses ${alfresco_dir}/tomcat/",
    creates => "${alfresco_dir}/tomcat/licenses",
    require => [
      Exec["extract-alfresco"],
      Tomcat::Webapp::Tomcat[$user]
    ]
  }
  # the database driver jar
  file { 'alfresco-db-driver':
    path => "${alfresco_dir}/tomcat/lib/${database_driver_jar}",
    source => $database_driver_source,
    ensure => file,
    owner => $user,
    group => $user,
    require => Tomcat::Webapp::Tomcat[$user],
  }
  # the configuration files
  file { "alfresco-global.properties":
    path => "${alfresco_dir}/tomcat/shared/classes/alfresco-global.properties",
    content => template("alfresco/alfresco-global.properties.erb"),
    require => Tomcat::Webapp::Tomcat[$user],
    notify => Tomcat::Webapp::Service[$user],
  }
  
  file { "${alfresco_dir}/tomcat/shared/classes/alfresco":
    ensure => directory,
    owner => $user,
    group => $user,
    mode => 0755,
    require => Tomcat::Webapp::Tomcat[$user],
  }
  
  file { "${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension":
    ensure => directory,
    owner => $user,
    group => $user,
    mode => 0755,
    require => File["${alfresco_dir}/tomcat/shared/classes/alfresco"],
    notify => Tomcat::Webapp::Service[$user],
  }
  
  file { "share-config-custom.xml":
    path => "${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml",
    content => template("alfresco/share-config-custom.xml.erb"),
    require => File["${alfresco_dir}/tomcat/shared/classes/alfresco/web-extension"],
  }
}
