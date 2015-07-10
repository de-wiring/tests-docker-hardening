require 'serverspec'
require 'pp'

require 'localhost/type/linux_audit_system.rb'

set :backend, :exec

# defaults
section_map = {
  '1' => {
    '1.1' => {
      :var_lib_docker_path => '/var/lib/docker'
    },
    '1.6' => {
      :docker_server_version => '1.7.0'
    },
  },
  '2' => {},
  '3' => {
    :config_file_perms => '644',
    :docker_environment_file => '/etc/sysconfig/docker',
    :docker_network_environment_file => '/etc/sysconfig/docker-network',
    :docker_registry_environment_file => '/etc/sysconfig/docker-registry',
    :docker_storage_environment_file => '/etc/sysconfig/docker-storage',
    :certificate_file_perms => '444',
    :registry_certificate_files => [],
    :ca_certificate_file => '',
    :server_certificate_file => '',
    :server_key_file => '',
    
  }
}

def dh_enable_section(s)
  s[:enabled] = true
  s.each do |k,v|
    dh_enable_section(v) if v.instance_of? Hash
  end
end

def dh_section(key)
  m = property[:dh_section_map]
  key_part = ''
  key.split('.').each do |k|
    key_part += '.' if key_part && key_part.size > 0
    key_part += k
    m_ = m[key_part]
    if m_.nil?
      m.store(key_part, {})
      m_ = m[key_part]
    end

    m = m_
  end
  m
end

def dh_enabled?(section_key)
  dh_section(section_key)[:enabled]
end

def dh_property(section_key, property_key)
  dh_section(section_key)[property_key]
end

def dh_disable(section_keys)
  section_keys = [ section_keys ] unless section_keys.instance_of? Array
  section_keys.each do |section_key|
    m = dh_section(section_key)
    m[:enabled] = false
  end
end

def dh_make_empty_sections(*sections)
  sections.each do |section|
    m = dh_section(section)
  end
end

def dh_checks_by_category(cat)
  case cat
    when :tls then 
      %W(2.9 3.17 3.18 3.19 3.20 3.21 3.22 3.23 3.24)
    when :registry then 
      %W(2.6 3.3 3.4 3.11 3.12)
    when :systemd then 
      %W(1.11 1.12 3.1 3.2 3.3 3.4 3.5 3.6)
    else []
  end
end


# set up section map structure. Fill in empty slots
dh_properties = { :dh_section_map => section_map }
set_property dh_properties

(1..18).each do |n|
  dh_make_empty_sections("1.#{n}")
end
(1..10).each do |n|
  dh_make_empty_sections("2.#{n}")
end
(1..26).each do |n|
  dh_make_empty_sections("3.#{n}")
end

# enable all by default
dh_enable_section(section_map)

# disable by environment
# - systemd
# - registr
# - use of sysconfig
# - systemd
# - tls

#dh_disable(dh_checks_by_category(:tls))
#dh_disable(dh_checks_by_category(:systemd))
#dh_disable(dh_checks_by_category(:registry))

