Rails.application.routes.draw do

  mount BcmsLdapAuth::Engine => "/bcms_ldap_auth"

  mount_browsercms
end
