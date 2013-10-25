$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bcms_ldap_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
      s.add_dependency "browsercms", "~> 3.5.6"

  s.name        = "bcms_ldap_auth"
  s.version     = BcmsLdapAuth::VERSION
  s.authors     = ["James Whitfield"]
  s.email       = ["jwhitfield@neilab.com"]
  s.homepage    = "http://neilab.com"
  s.summary     = "TODO: Summary of BcmsLdapAuth."
  s.description = "TODO: Description of BcmsLdapAuth."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.files -= Dir['lib/tasks/module_tasks.rake']
  s.test_files = Dir["test/**/*"]

  # Depend on BrowserCMS,rather than Rails 
  # s.add_dependency "rails", "~> 3.2.15"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "activerecord-jdbcsqlite3-adapter"
  s.add_dependency 'adauth'
end
