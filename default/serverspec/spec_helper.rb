require 'serverspec'

require 'localhost/type/linux_audit_system.rb'

set :backend, :exec

section_map = {
  '1' => {
    '1.1' => {
      :var_lib_docker_path => '/var/lib/docker'
    },
    '1.2' => {},
    '1.6' => {
      :docker_server_version => '1.7.0'
    },
    '1.7' => {},
    '1.8' => {},
  }
}

def cis_enable_section(s)
  s[:enabled] = true
  s.each do |k,v|
    cis_enable_section(v) if v.instance_of? Hash
  end
end
# enable all by default
cis_enable_section(section_map)

properties = { :cis_section_map => section_map }

set_property properties


def cis_section(key)
  m = property[:cis_section_map]
  key_part = ''
  key.split('.').each do |k|
    key_part += '.' if key_part && key_part.size > 0
    key_part += k
    m = m[key_part]
  end
  m
end

def cis_enabled?(section_key)
  cis_section(section_key)[:enabled]
end

def cis_property(section_key, property_key)
  cis_section(section_key)[property_key]
end

def cis_disable(section_key)
  m = cis_section(section_key)
  m[:enabled] = false
end


