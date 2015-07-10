# tests-docker-hardening

require 'spec_helper.rb'

perms = dh_property('3',:config_file_perms)

#
# -- Tests for Docker Daemon Configuration
#
describe '3 - Daemon Configuration Files', :if => dh_enabled?('3') do

  # systemd only
  describe '3.1 - docker.service file ownership / systemd', :if => dh_enabled?('3.1') do
    describe file '/usr/lib/systemd/system/docker.service' do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.2 - docker.service file permissions / systemd', :if => dh_enabled?('3.2') do
    describe file '/usr/lib/systemd/system/docker.service' do
      it { should be_mode perms }
    end
  end  

  describe '3.3 - docker-registry.service file ownership / systemd', :if => dh_enabled?('3.3') do
    describe file '/usr/lib/systemd/system/docker-registry.service' do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.4 - docker-registry.service file permissions / systemd', :if => dh_enabled?('3.4') do
    describe file '/usr/lib/systemd/system/docker-registry.service' do
      it { should be_mode perms }
    end
  end  
    
  describe '3.5 - docker.socket file ownership / systemd', :if => dh_enabled?('3.5') do
    describe file '/usr/lib/systemd/system/docker.socket' do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.6 - docker.socket file permissions / systemd', :if => dh_enabled?('3.6') do
    describe file '/usr/lib/systemd/system/docker.socket' do
      it { should be_mode perms }
    end
  end  

  describe '3.7 - docker environment file ownership', :if => dh_enabled?('3.7') do
    describe file(dh_property('3',:docker_environment_file)) do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.8 - docker environment file permissions', :if => dh_enabled?('3.8') do
    describe file(dh_property('3',:docker_environment_file)) do
      it { should be_mode perms }
    end
  end  

  describe '3.9 - docker network environment file ownership', :if => dh_enabled?('3.9') do
    describe file(dh_property('3',:docker_network_environment_file)) do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.10 - docker network environment file permissions', :if => dh_enabled?('3.10') do
    describe file(dh_property('3',:docker_network_environment_file)) do
      it { should be_mode perms }
    end
  end  

  describe '3.11 - docker registry environment file ownership', :if => dh_enabled?('3.11') do
    describe file(dh_property('3',:docker_registry_environment_file)) do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.12 - docker registry environment file permissions', :if => dh_enabled?('3.12') do
    describe file(dh_property('3',:docker_registry_environment_file)) do
      it { should be_mode perms }
    end
  end  

  describe '3.13 - docker storage environment file ownership', :if => dh_enabled?('3.13') do
    describe file(dh_property('3',:docker_storage_environment_file)) do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.14 - docker storage environment file permissions', :if => dh_enabled?('3.14') do
    describe file(dh_property('3',:docker_storage_environment_file)) do
      it { should be_mode perms }
    end
  end  

  describe '3.15 - /etc/docker file ownership', :if => dh_enabled?('3.15') do
    describe file '/etc/docker' do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end  

  describe '3.16 - /etc/docker file permissions', :if => dh_enabled?('3.16') do
    describe file '/etc/docker' do
      it { should be_mode '755' }
    end
  end  

  # registry certificates, iterate over given cert files
  ( dh_property('3',:registry_certificate_files) || []).each do |cert_file| 
    describe "3.17 registry certificate file #{cert_file} ownership", :if => dh_enabled?('3.17') do
      describe file cert_file do
        it { should be_file }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
      end
    end
  
    describe "3.18 registry certificate file #{cert_file} permissions", :if => dh_enabled?('3.18') do
      describe file cert_file do
        it { should be_mode dh_property('3',:cert_file_perms) }
      end
    end  
  end
      
  describe '3.19 ca certificate file ownership', :if => dh_enabled?('3.19') do
    describe file dh_property('3', :ca_certificate_file) do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
  
  describe '3.20 ca certificate file ownership', :if => dh_enabled?('3.20') do
    describe file dh_property('3', :ca_certificate_file) do
      it { should be_mode dh_property('3',:cert_file_perms) }
    end
  end  
  
  describe '3.21 server certificate file ownership', :if => dh_enabled?('3.21') do
    describe file dh_property('3', :server_certificate_file) do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
  
  describe '3.22 server certificate file ownership', :if => dh_enabled?('3.22') do
    describe file dh_property('3', :server_certificate_file) do
      it { should be_mode dh_property('3',:cert_file_perms) }
    end
  end  
  
  describe '3.23 server key file ownership', :if => dh_enabled?('3.23') do
    describe file dh_property('3', :server_key_file) do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
  
  describe '3.24 server key file ownership', :if => dh_enabled?('3.24') do
    describe file dh_property('3', :server_key_file) do
      it { should be_mode '400' }
    end
  end  
  
  describe '3.25 - /var/run/docker.sock file ownership', :if => dh_enabled?('3.25') do
    describe file '/var/run/docker.sock' do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'docker' }
    end
  end  

  describe '3.26 - /var/run/docker.sock file permissions', :if => dh_enabled?('3.26') do
    describe file '/var/run/docker.sock' do
      it { should be_mode '660' }
    end
  end  


end

