# = Class: alfresco::params
#
# Contains default values for Alfresco.
#
# == Example
#
# This class does not need to be directly included.
#

class alfresco::params {

  $alfresco_host            = $fqdn
  $alfresco_port            = '8080'
  $alfresco_protocol        = 'http'
  $share_host               = $alfresco_host
  $share_port               = $alfresco_port
  $share_protocol           = $alfresco_protocol
  $cifs_enabled             = undef
  $solr_host                = undef
  $solr_port                = undef
  $solr_port_ssl            = undef
  $database_user            = 'alfresco'
  $database_password        = 'alfresco'
  $database_driver          = 'org.postgresql.Driver'
  $database_url             = 'jdbc:postgresql://localhost/alfresco'
  $ftp_enabled              = 'false'
  $guest_login              = 'false'
  $orpahn_protect_days      = undef
  $orphan_cleanup_cron      = undef
  $reencrypt                = undef
  $ooo_enabled              = 'false'
  $img_exe                  = '/usr/bin/convert'
  $swf_exe                  = '/usr/bin/pdf2swf'
  $ooo_exe                  = '/usr/bin/soffice'
  $smtp_host                = 'localhost'
  $smtp_port                = 25
  $smtp_user                = undef
  $smtp_password            = undef
  $smtp_encoding            = 'UTF-8'
  $smtp_from_default        = 'alfresco@${fqnd}'
  $smtp_from_enabled        = 'false'
  $smtp_auth                = 'false'
  $smtp_timeout             = undef
  $smtp_starttls_enabled    = undef
  $smtp_from                = undef
  $smtp_testmessage_send    = undef
  $smtp_testmessage_to      = undef
  $smtp_testmessage_subject = undef
  $smtp_testmessage_text    = undef
  $mail_inbound_enabled     = undef
  $mail_enabled             = undef
  $imap_enabled             = undef

  if $alfresco::cifs_enabled == 'true' {
    $cifs_servername           = $hostname
    $cifs_domain               = $domain
    $cifs_hostannounce         = 'false'
    $cifs_tcpip_port           = 445
    $cifs_netbios_nameport     = 137
    $cifs_netbios_datagramport = 138
    $cifs_netbios_sessionport  = 139
  }
  else {
    $cifs_servername           = undef
    $cifs_domain               = undef
    $cifs_hostannounce         = undef
    $cifs_tcpip_port           = undef
    $cifs_netbios_nameport     = undef
    $cifs_netbios_datagramport = undef
    $cifs_netbios_sessionport  = undef
  }

  if $alfresco::mail_inbound_enabled == 'true' and $alfresco::mail_enabled == 'true' {
    $mail_port            = 1025
    $mail_domain          = $domain
    $mail_unknown_user    = 'anonymous'
    $mail_allowed_senders = '.*'
  }
  else {
    $mail_port            = undef
    $mail_domain          = undef
    $mail_unknown_user    = undef
    $mail_allowed_senders = undef
  }

  if $alfresco::imap_enabled == 'true' {
    $imap_port = 1143
    $imap_host = $fqdn
  }
  else {
    $imap_port = undef
    $imap_host = undef
  }

  case $::osfamily {
    debian: {
      $dir_root               = undef
      $dir_keystore           = undef
      $user                   = 'alfresco'
      $number                 = 7
      $version                = '4.2.a'
      $build                  = 4428
      $alfresco_contextroot   = 'alfresco'
      $share_contextroot      = 'share'
      $webapp_base            = '/srv'
      $imagemagick_version    = '6.6.9'
      $tomcat_memory          = '1024m'
      $database_driver_jar    = 'postgresql-9.1-902.jdbc4.jar'
      $database_driver_source = 'puppet:///modules/alfresco/db/postgresql-9.1-902.jdbc4.jar'
    }
    gentoo: {
      $dir_root               = '/var/lib/alfresco-4.2/data'
      $dir_keystore           = '/var/lib/alfresco-4.2/keystore'
      $user                   = undef
      $number                 = undef
      $version                = undef
      $build                  = undef
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
