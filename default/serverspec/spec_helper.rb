require 'serverspec'

set :backend, :exec

# -- needed for docker hardening spec
require 'type/linux_audit_system.rb'
require 'spec_helper_hardening.rb'

# set up section map structure. Fill in empty slots
dh_init_section_map

# disable by environment setting by named category:
# - systemd
# - registry, docker-network, docker-storage
# - systemd
# - tls
(ENV['DH_DISABLE_CAT'] || '').split(' ').each do |cat|
  sub_section = dh_checks_by_category(cat.downcase.to_sym)
  dh_disable sub_section
end

# -- docker hardening spec
