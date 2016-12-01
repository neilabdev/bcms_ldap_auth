
module BcmsLdapAuth

  def self.config
    @config
  end

  def self.configure
    @config = Config.new
    yield(@config)

    Adauth.configure do |c|

      [:domain, :port, :base, :server, :encryption, :query_user, :query_password, :allow_fallback,
       :allowed_groups, :denied_groups, :allowed_ous, :denied_ous, :contains_nested_groups, :anonymous_bind].each do |key|
        c.send("#{key.to_s}=",@config.send("#{key.to_s}"))
      end
    end if @config.enabled
  end

  class Config
    attr_accessor   :domain, :port, :base, :server, :encryption, :query_user, :query_password, :allow_fallback,
                    :allowed_groups, :denied_groups, :allowed_ous, :denied_ous, :contains_nested_groups,
                    :anonymous_bind, :ignore_login_domain,:ignore_sync_failures, :minimum_timeout,:maximum_timeout,
                    :default_groups,:default_group_type, :sync_ldap_groups, :cache_authentication,
                    :cms_user_mappings,:cms_user_search_field, :adauth_user_mappings, :enabled


    def initialize
      @port = 389
      @allowed_groups = []
      @allowed_ous = []
      @denied_groups =[]
      @denied_ous = []
      @allow_fallback = false
      @contains_nested_groups = false
      @anonymous_bind = false
      @ignore_login_domain = false
      @ignore_sync_failures = false
      @default_groups= nil
      @default_group_type = "Registered Public User"
      @cache_authentication = false
      @sync_ldap_groups = false
      @mappings = {}
      @cms_user_search_field = []
      @minimum_timeout = 3
      @maximum_timeout = 3
      @enabled = true
      @adauth_user_mappings = Adauth::AdObjects::User::Fields
    end

    # Guesses the Server and Base string
    def domain=(s)
      @domain = s
      @server ||= s
      @base ||= s.gsub(/\./,', dc=').insert(0, 'dc=')
    end

    def adauth_user_mappings=(value)
      raise "ad_user_mapping must behave like a hash" unless value.respond_to?(:to_hash)
     # @adauth_user_mappings = value.to_hash
      value.to_hash.each_pair do |k,v|
        Adauth.add_field(Adauth::AdObjects::User,k,v)
      end
    end

  end
end
