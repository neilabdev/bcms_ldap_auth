module Cms


  User.class_eval do

    include Adauth::Rails::ModelBridge

    # AdauthMappings
    #
    # A hash which controls how Adauth maps its values to rails e.g.
    #
    # AdauthMappings = {
    #   :name => :login
    # }
    #
    # This will store Adauths 'login' value in the 'name' field.

    AdauthMappings = {
        :login => :login,
        :first_name => :first_name,
        :last_name=> :last_name,
        :email=>:email,
      #  :group_strings => :cn_groups
    }


    # This will cause RailsModel.find_by_name(AdauthObject.login)
    # The Order is [adauth_field, rails_field]

    AdauthSearchField = [:login, :login]

    def self.authenticate_with_ldap(login, password)
      u = authenticate_without_ldap(login, password)
      return u unless u.nil?

      ldap_user = Adauth.authenticate(login, password)

      if ldap_user then
        u = self.return_and_create_from_adauth(ldap_user)
        return nil unless u.save
      end

      u
    end


    def sync_group=(group_names)


    end



    class << self
      alias_method_chain :authenticate, :ldap
    end

  end
end
