# = Class: alfresco::params
#
# Contains default values for Alfresco.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::params {

  $alfresco_host             = $fqdn
  $alfresco_port             = '8080'
  $alfresco_protocol         = 'http'
  $share_host                = $alfresco_host
  $share_port                = $alfresco_port
  $share_protocol            = $alfresco_protocol
  $solr_host                 = undef
  $solr_port                 = undef
  $solr_port_ssl             = undef
  $cifs_enabled              = undef
  $cifs_servername           = undef
  $cifs_domain               = undef
  $cifs_hostannounce         = undef
  $cifs_tcpip_port           = undef
  $cifs_netbios_nameport     = undef
  $cifs_netbios_datagramport = undef
  $cifs_netbios_sessionport  = undef
  $database_user             = 'alfresco'
  $database_password         = 'alfresco'
  $database_driver           = 'org.postgresql.Driver'
  $database_url              = 'jdbc:postgresql://localhost/alfresco'
  $ftp_enabled               = 'false'
  $guest_login               = 'false'
  $orpahn_cleanup            = undef
  $orpahn_day                = undef
  $orphan_cron               = undef
  $reencrypt                 = undef
  $ooo_enabled               = 'false'
  $img_exe                   = '/usr/bin/convert'
  $swf_exe                   = '/usr/bin/pdf2swf'
  $ooo_exe                   = '/usr/bin/soffice'
  $smtp_host                 = 'localhost'
  $smtp_port                 = 25
  $smtp_user                 = undef
  $smtp_password             = undef
  $smtp_encoding             = 'UTF-8'
  $smtp_from_default         = "alfresco@${fqdn}"
  $smtp_from_enabled         = 'false'
  $smtp_auth                 = 'false'
  $smtp_timeout              = undef
  $smtp_starttls_enabled     = undef
  $smtp_from                 = undef
  $smtp_testmessage_send     = undef
  $smtp_testmessage_to       = undef
  $smtp_testmessage_subject  = undef
  $smtp_testmessage_text     = undef
  $mail_inbound_enabled      = undef
  $mail_enabled              = undef
  $mail_port                 = undef
  $mail_domain               = undef
  $mail_unknown_user         = undef
  $mail_allowed_senders      = undef
  $imap_enabled              = undef
  $imap_port                 = undef
  $imap_host                 = undef
  $custom_settings           = []

  case $::osfamily {
    debian: {
      $package_name           = undef
      $version                = '4.2.a'
      $number                 = 7
      $build                  = 4428
      $webapp_base            = '/srv'
      $user                   = 'alfresco'
      $group                  = 'alfresco'
      $alfresco_dir           = "${webapp_base}/${user}"
      $dir_root               = undef
      $dir_keystore           = undef
      $alfresco_contextroot   = 'alfresco'
      $share_contextroot      = 'share'
      $webapp_base            = '/srv'
      $imagemagick_version    = '6.6.9'
      $tomcat_memory          = '1024m'
      $database_driver_jar    = 'postgresql-9.1-902.jdbc4.jar'
      $database_driver_source = 'puppet:///modules/alfresco/db/postgresql-9.1-902.jdbc4.jar'
    }
    gentoo: {
      $package_name           = 'www-apps/alfresco-bin'
      $version                = 'latest'
      $number                 = undef
      $build                  = undef
      $user                   = 'root'
      $group                  = 'alfresco'
      $alfresco_dir           = '/etc/alfresco-4.2/'
      $dir_root               = '/var/lib/alfresco-4.2/data'
      $dir_keystore           = '/etc/alfresco-4.2/keystore'
      $alfresco_contextroot   = undef
      $share_contextroot      = undef
      $webapp_base            = undef
      $imagemagick_version    = undef
      $tomcat_memory          = undef
      $database_driver_jar    = undef
      $database_driver_source = undef
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
