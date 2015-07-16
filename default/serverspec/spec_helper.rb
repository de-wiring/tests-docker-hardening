require 'serverspec'

set :backend, :exec


# -- needed for docker hardening spec
require 'localhost/type/linux_audit_system.rb'
require 'spec_helper_hardening.rb'

# set up section map structure. Fill in empty slots
dh_init_section_map

# disable by environment setting
# - systemd
# - registry, docker-network, docker-storage
# - systemd
# - tls

#[ :tls, :systemd, :docker_registry, :docker_network, :docker_storage ].each do |cat|
#  sub_section = dh_checks_by_category(cat)
#  dh_disable sub_section
#end

# -- docker hardening spec
