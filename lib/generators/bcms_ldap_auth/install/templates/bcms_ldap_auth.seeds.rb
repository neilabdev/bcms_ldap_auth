#ldap_group_type = Cms::GroupType.create!(:name=>"LDAP User",:guest=>true,:cms_access=>false)

require 'cms/data_loader'
extend Cms::DataLoader

create_group_type(:ldap_user_type, :name => "LDAP User", :cms_access => true)
create_group(:ldap_user, :name => 'LDAP User', :code => 'ldap', :group_type => group_types(:ldap_user_type))