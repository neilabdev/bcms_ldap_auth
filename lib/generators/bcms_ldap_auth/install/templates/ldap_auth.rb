# NOTE: bcms_ldap_auth internaly uses Adauth to configure ActiveDirectory/LDAP authentication.

BcmsLdapAuth.configure do |c|
	# The Domain name of your Domain
	#
	# This is usually my_company.com or my_company.local
	#
	# If you don't know your domain contact your IT support,
	# it will be the DNS suffix applied to your machines
	#c.domain = "example.com"

	# Adauth needs a query user to interact with the domain.
	# This user can be anything with domain access
	#
	# If Adauth doesn't work contact your IT support and make sure this account has full query access
	#c.query_user = "ldap_user"
	#c.query_password = "password"

	# The IP address or Hostname of a DC (Domain Controller) on your network
	#
	# This could be anything and probably wont be 127.0.0.1
	#
	# Again contact your IT Support if you can't work this out
	#c.server = "127.0.0.1"

	# The LDAP base of your domain/intended users
	#
	# For all users in your domain the base would be:
	# dc=example, dc=com
	# OUs can be prepeneded to restrict access to your app
	#c.base = "dc=example, dc=com"

  # The port isn't always needed as Adauth defaults to 389 the LDAP Port
	#
	# If your DC is on the other side of a firewall you may need to change the port
	# If your DC is using SSL, the port may be 636.
	#c.port = 389

	# If your DC is using SSL, set encryption to :simple_tls
	#c.encryption = :simple_tls

	# Windows Security groups to allow
	#
	# Only allow members of set windows security groups to login
	#
	# Takes an array for group names
	#c.allowed_groups = ["Group3"]

	# Windows Security groups to deny
	#
	# Only allow users who aren't in these groups to login
	#
	# Takes an array for group names
	#c.denied_groups = ["Group1", "Group2"]


  # When a user account is created or logs in via LDAP, they should automatically be assigned the
  # following group name and type

  # Causes users who are imported from LDAP to be be included in a specific group ALWAYS.
  #c.default_groups = ["Connex Authenticated User"]
  #c.default_group_type = "Registered Public User"

  # Synchronizes local LDAP groups with those in LDAP
  #c.sync_ldap_groups = false


  # To disabled LDAP auth so that auth only uses local database.
  #c.enabled = false


  # To enable Timeouts for LDAP connectivity
  # c.minimum_timeout = 3  # First request timeout  in seconds.
  # c.maximum_timeout = 2  # if first attempt times out, resubmit for N seconds. If < 1 seconds, don't resubmit.


  # Mappings
  #
  # A hash which controls how Adauth maps its values to rails e.g.
  #
  # This will store Adauths 'login' value in the 'name' field.
  # c.cms_user_mappings = {  :login => :name,  :email => :email }

  # This will cause RailsModel.find_by_name(AdauthObject.login)
  # The Order is [adauth_field, rails_field]
  # c.cms_user_search_field = [:login, :login]

  ### Add fields to Adauth::AdObjects::User::Fields
  # c.adauth_user_mappings =  { :email => :other_field_that_ldap_implements }
end