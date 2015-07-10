# tests-docker-hardening

require 'spec_helper.rb'

#
# -- Tests for Docker Host Configuration
#
describe '1 - Host Configuration', :if => dh_enabled?('1') do

  describe '1.1 - Create a separate partition for containers', :if => dh_enabled?('1.1') do
  
    describe file( dh_property('1.1',:var_lib_docker_path) ) do
      it { should exist }
      it { should be_mounted }
    end

  end  

  describe '1.2 - Use the updated Linux Kernel', :if => dh_enabled?('1.2') do
    # compare major and minor versions separately

    describe command "test `uname -r | awk -F'.' '{ print $1 }'` -ge 3" do
      its(:exit_status) { should eq 0 }
    end

    describe command "test `uname -r | awk -F'.' '{ print $2 }'` -ge 10" do
      its(:exit_status) { should eq 0 }
    end
  end

  # NOT COVERED: 1.3 - Do not use development tools in production
  # NOT COVERED: 1.4 - Harden the container host
  # NOT COVERED: 1.5 - Remove all non-essential services from the host

  describe '1.6 - Keep Docker up to date', :if => dh_enabled?('1.6') do
    describe command 'docker version' do
      its(:stdout) { should match /^Server version: #{dh_property('1.6',:docker_server_version)}/ }
    end
  end

  describe '1.7 - Only allow trusted users to control Docker daemon', :if => dh_enabled?('1.7') do
    # essentially, check that docker group has no members, using lid
    describe command 'lid -g docker' do
      its(:stdout) { should eq '' }
      its(:exit_status) { should eq 0 }
    end
  end

  # audit rules 1.8- go into 1_8_host_audit_configuration_spec.rb

end
