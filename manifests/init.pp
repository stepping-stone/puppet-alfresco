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
	$user = "alfresco",	
	$database_name = "alfresco",
	$database_driver = "org.postgresql.Driver",
	$database_driver_jar = "postgresql-9.1-902.jdbc4.jar",
	$database_driver_source = "puppet:///modules/alfresco/db/postgresql-9.1-902.jdbc4.jar",
	$database_url = "jdbc:postgresql://localhost/alfresco",
	$database_user = "alfresco",
	$database_pass = "alfresco",
	$number = 7,
	$version = "4.2.a",
	$build = "4428",
	$alfresco_host = $fqdn,
	$alfresco_protocol = "http",
	$alfresco_port = "8080",
	$alfresco_contextroot = "alfresco",
	$share_host = $fqdn,
	$share_protocol = "http",
	$share_port = "8080",
	$share_contextroot = "share",
	$webapp_base = "/srv",
	$memory = "1024m",
	$imagemagick_version = "6.6.9",
	$smtp_host = "localhost",
	$smtp_port = "25",
	$smtp_username= "anonymous",
	$smtp_password= '',
	$smtp_encoding="UTF-8",
	$smtp_from_default="alfresco@${domain}",
	$smtp_auth="false",
	$mail_enabled="true",
	$mail_inbound_enabled="true",
	$mail_port="1025",
	$mail_domain=$domain,
	$mail_unknown_user="anonymous",
	$mail_allowed_senders=".*",
	$imap_enabled = "false",
	$imap_port = "1143",
	$imap_host = $fqdn,
	$authentication_chain="alfrescoNtlm1:alfrescoNtlm",
	$custom_settings=[]
) inherits alfresco::params {

  case $::osfamily {
    debian: {
      class { 'alfresco::debian':
      }
    }
    gentoo: {
      class { 'alfresco::gentoo':
      }
    }
    default: {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }
	
}
