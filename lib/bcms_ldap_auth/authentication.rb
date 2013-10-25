module Cms

  User.class_eval do

    include Adauth::Rails::ModelBridge

    AdauthMappings = {
        :login => :login,
        :group_strings => :cn_groups
    }

    AdauthSearchField = [:login, :login]

    def self.authenticate_with_ldap(login, password)
      u = authenticate_without_ldap(login, password)
      u
    end

    class << self
      alias_method_chain :authenticate, :ldap
    end

  end
end
