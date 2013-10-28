require 'cms/module_installation'

class BcmsLdapAuth::InstallGenerator < Cms::ModuleInstallation
  source_root File.expand_path("../templates", __FILE__)

  #add_migrations_directory_to_source_root __FILE__

  def copy_migrations
    #rake 'bcms_ldap_auth:install:migrations'
  end



  # Uncomment to add module specific seed data to a project.
  def add_seed_data_to_project

    template "bcms_ldap_auth.seeds.rb", "db/bcms_ldap_auth.seeds.rb"
    append_file "db/seeds.rb", "\nrequire File.expand_path('../bcms_ldap_auth.seeds.rb', __FILE__)\n"

    template "ldap_auth.rb","config/initializers/ldap_auth.rb"
  #  copy_file "../bcms_ldap_auth.seeds.rb", "db/bcms_ldap_auth.seeds.rb"
  #  append_to_file "db/seeds.rb", "load File.expand_path('../bcms_ldap_auth.seeds.rb', __FILE__)\n"
  end
  
  def add_routes
    mount_engine(BcmsLdapAuth)
  end


  def self.next_migration_number(path)
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
      @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end

  def copy_migrations
    #migration_template "create_something.rb", "db/migrate/create_something.rb"
  end

    
end