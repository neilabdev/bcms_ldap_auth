module Cms

  User.class_eval do

    def self.authenticate_with_ldap(login, password)
      u = authenticate_without_ldap(login, password)
      u
    end

    class << self
      alias_method_chain :authenticate, :ldap
    end

  end
end
