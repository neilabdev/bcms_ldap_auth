
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
                    :anonymous_bind, :enabled

    def initialize
      @port = 389
      @allowed_groups = []
      @allowed_ous = []
      @denied_groups =[]
      @denied_ous = []
      @allow_fallback = false
      @contains_nested_groups = false
      @anonymous_bind = false
      @enabled = true
    end

    # Guesses the Server and Base string
    def domain=(s)
      @domain = s
      @server ||= s
      @base ||= s.gsub(/\./,', dc=').insert(0, 'dc=')
    end
  end
end
