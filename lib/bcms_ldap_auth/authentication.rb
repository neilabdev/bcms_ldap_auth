module Cms


  User.class_eval do

    include Adauth::Rails::ModelBridge



    def self.authenticate_with_ldap(login, password)
      u = authenticate_without_ldap(login, password)
      return u unless u.nil?

      Cms::User.transaction do |transaction|
        ldap_user = Adauth.authenticate(login, password)

        if ldap_user then
          u = self.return_and_create_from_adauth(ldap_user)
          u.sync_group = ldap_user.groups.andand.collect { |g| g.name }
          u.password=u.password_confirmation=password  # Remembers last successful password in LDAP. Should we make it unusable so that LDAP users only auth from LDAP?
          #return nil unless u.save
          unless u.save
            return nil
          end
        end
      end

      u
    end


    def sync_group=(group_names)
      return unless group_names.is_a?(Array)
      ldap_group_type = nil
      user_groups = []

      group_names.each do |name|
        # Add or Create groups user not already associated with
        ldap_group_type ||= Cms::GroupType.where({:name => "LDAP User"}).first
        user_groups ||= self.groups.collect { |g| g.name }
        ldap_group = Cms::Group.where({:name => name, :code => "ldap"}).first
        ldap_group =  Cms::Group.create!(:name => name, :code => "ldap", :group_type_id => ldap_group_type.id) if ldap_group.nil?

        unless user_groups.include? ldap_group.name then
          self.groups << ldap_group
        end
      end


    end


    class << self
      alias_method_chain :authenticate, :ldap
    end

  end

  class Mappings
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
        :last_name => :last_name,
        :email => :email,
        #  :group_strings => :cn_groups
    }


    # This will cause RailsModel.find_by_name(AdauthObject.login)
    # The Order is [adauth_field, rails_field]

    AdauthSearchField = [:login, :login]
  end

  class User
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
        :last_name => :last_name,
        :email => :email,
        #  :group_strings => :cn_groups
    }


    # This will cause RailsModel.find_by_name(AdauthObject.login)
    # The Order is [adauth_field, rails_field]

    AdauthSearchField = [:login, :login]
  end
end
