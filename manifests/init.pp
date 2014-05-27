# = Class: alfresco
# 
# Install and configure Alfresco.
#
# == Parameters
#
# [*user*]
#
# The name of the alfresco user.
#
# == Example
#
#     class { 'alfresco':
#       $user = 'example',
#     }
#
# == See Also
#
#

class alfresco (
  $alfresco_host             = $alfresco::params::alfresco_host,
  $alfresco_port             = $alfresco::params::alfresco_port,
  $alfresco_protocol         = $alfresco::params::alfresco_protocol,
  $share_host                = $alfresco::params::share_host,
  $share_port                = $alfresco::params::share_port,
  $share_protocol            = $alfresco::params::share_protocol,
  $cifs_enabled              = $alfresco::params::cifs_enabled,
  $cifs_servername           = $alfresco::params::cifs_servername,
  $cifs_domain               = $alfresco::params::cifs_domain,
  $cifs_hostannounce         = $alfresco::params::cifs_hostannounce,
  $cifs_tcpip_port           = $alfresco::params::cifs_tcpip_port,
  $cifs_netbios_nameport     = $alfresco::params::cifs_netbios_nameport,
  $cifs_netbios_datagramport = $alfresco::params::cifs_netbios_datagramport,
  $cifs_netbios_sessionport  = $alfresco::params::cifs_netbios_sessionport,
  $solr_host                 = $alfresco::params::solr_host,
  $solr_port                 = $alfresco::params::solr_port,
  $solr_port_ssl             = $alfresco::params::solr_port_ssl,
  $database_name             = $alfresco::params::database_name,
  $database_host             = $alfresco::params::database_host,
  $database_port             = $alfresco::params::database_port,
  $database_user             = $alfresco::params::database_user,
  $database_password         = $alfresco::params::database_password,
  $database_driver           = $alfresco::params::database_driver,
  $database_url              = $alfresco::params::database_url,
  $ftp_enabled               = $alfresco::params::ftp_enabled,
  $guest_login               = $alfresco::params::guest_login,
  $orphan_cleanup            = $alfresco::params::orphan_cleanup,
  $orphan_days               = $alfresco::params::orphan_days,
  $orphan_cron               = $alfresco::params::orphan_cron,
  $reencrypt                 = $alfresco::params::reencrypt,
  $ooo_enabled               = $alfresco::params::ooo_enabled,
  $img_exe                   = $alfresco::params::img_exe,
  $swf_exe                   = $alfresco::params::swf_exe,
  $ooo_exe                   = $alfresco::params::ooo_exe,
  $smtp_host                 = $alfresco::params::smtp_host,
  $smtp_port                 = $alfresco::params::smtp_port,
  $smtp_user                 = $alfresco::params::smtp_user,
  $smtp_password             = $alfresco::params::smtp_password,
  $smtp_encoding             = $alfresco::params::smtp_encoding,
  $smtp_from_default         = $alfresco::params::smtp_from_default,
  $smtp_from_enabled         = $alfresco::params::smtp_from_enabled,
  $smtp_auth                 = $alfresco::params::smtp_auth,
  $smtp_timeout              = $alfresco::params::smtp_timeout,
  $smtp_starttls_enabled     = $alfresco::params::smtp_starttls_enabled,
  $smtp_from                 = $alfresco::params::smtp_from,
  $smtp_testmessage_send     = $alfresco::params::smtp_testmessage_send,
  $smtp_testmessage_to       = $alfresco::params::smtp_testmessage_to,
  $smtp_testmessage_subject  = $alfresco::params::smtp_testmessage_subject,
  $smtp_testmessage_text     = $alfresco::params::smtp_testmessage_text,
  $mail_inbound_enabled      = $alfresco::params::mail_inbound_enabled,
  $mail_port                 = $alfresco::params::mail_port,
  $mail_domain               = $alfresco::params::mail_domain,
  $mail_unknown_user         = $alfresco::params::mail_unknown_user,
  $mail_allowed_senders      = $alfresco::params::mail_allowed_senders,
  $mail_enabled              = $alfresco::params::mail_enabled,
  $imap_enabled              = $alfresco::params::imap_enabled,
  $imap_port                 = $alfresco::params::imap_port,
  $imap_host                 = $alfresco::params::imap_host,
  $alfresco_dir              = $alfresco::params::alfresco_dir,
  $dir_root                  = $alfresco::params::dir_root,
  $dir_keystore              = $alfresco::params::dir_keystore,
  $user                      = $alfresco::params::user,
  $group                     = $alfresco::params::group,
  $package_name              = $alfresco::params::package_name,
  $version                   = $alfresco::params::version,
  $number                    = $alfresco::params::number,
  $build                     = $alfresco::params::build,
  $alfresco_contextroot      = $alfresco::params::alfresco_contextroot,
  $share_contextroot         = $alfresco::params::share_contextroot,
  $webapp_base               = $alfresco::params::webapp_base,
  $imagemagick_version       = $alfresco::params::imagemagick_version,
  $tomcat_memory             = $alfresco::params::tomcat_memory,
  $database_driver_jar       = $alfresco::params::database_driver_jar,
  $database_driver_source    = $alfresco::params::database_driver_source,
  $custom_settings           = $alfresco::params::custom_settings,
) inherits alfresco::params {

  case $::osfamily {
    debian: {
      $database_user_debian     = $database_user
      $database_password_debian = $database_password
    }
  }

  class { 'alfresco::install': } ->
  class { 'alfresco::config': } ~>
  class { 'alfresco::service': }
	
}
