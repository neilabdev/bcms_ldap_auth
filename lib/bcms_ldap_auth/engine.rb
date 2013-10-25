require 'browsercms'
module BcmsLdapAuth
  class Engine < ::Rails::Engine
    isolate_namespace BcmsLdapAuth
		include Cms::Module

    initializer 'bcms_cas.load_dependencies' do
      require 'bcms_ldap_auth/authentication'
    end
  end
end
