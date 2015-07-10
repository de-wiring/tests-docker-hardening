# tests-docker-hardening

require 'spec_helper.rb'

#
# -- Tests for Docker Daemon Configuration
#
describe '2 - Daemon Configuration', :if => dh_enabled?('2') do

  describe '2.1 - Do not use lxc execution driver', :if => dh_enabled?('2.1') do
 
    describe command 'docker info | grep ^Execution Driver' do
      it { should_not match /lxc/ } 
    end
    describe process 'docker' do
      its(:args) { should_not match /lxc/ } 
    end

  end  

  describe '2.2 - Restrict network traffic', :if => dh_enabled?('2.2') do
 
    describe process 'docker' do
      its(:args) { should match /--icc=false/ } 
    end

  end  

  describe '2.3 - Log Level', :if => dh_enabled?('2.3') do
 
    describe process 'docker' do
      its(:args) { should match /--log-level=info/ } 
    end

  end  

  describe '2.4 - Allow Docker to make changes to iptables', :if => dh_enabled?('2.4') do
 
    describe process 'docker' do
      its(:args) { should_not match /--iptables=false/ } 
    end

  end  

  describe '2.5 - Insecure Registries', :if => dh_enabled?('2.5') do
 
    describe process 'docker' do
      its(:args) { should_not match /--insecure-registry/ } 
    end

  end  

  describe '2.6 - Local Registry mirror', :if => dh_enabled?('2.6') do
 
    describe process 'docker' do
      its(:args) { should match /--registry-mirror=https:.*/ } 
    end

  end  

  describe '2.7 - Do not use aufs driver', :if => dh_enabled?('2.7') do
 
    describe command 'docker info | grep ^Storage Driver' do
      it { should_not match /aufs/ } 
    end
    describe process 'docker' do
      its(:args) { should_not match /-s aufs/ } 
    end

  end  

  describe '2.8 - Do not bind Docker to another IP/Port or a Unix socket', :if => dh_enabled?('2.8') do

    describe process 'docker' do
      it { should be_running }
      its(:args) { should_not match /-H/ } 
    end

  end

  describe '2.9 - TLS authentication', :if => dh_enabled?('2.9') do

    describe process 'docker' do
      its(:args) { should match /--tlsverify/ } 
      its(:args) { should match /--tlscacert/ } 
      its(:args) { should match /--tlscert/ } 
      its(:args) { should match /--tlskey/ } 
    end

  end

  describe '2.10 - Set default ulimits', :if => dh_enabled?('2.10') do

    describe process 'docker' do
      its(:args) { should match /--default-ulimit/ } 
      #its(:args) { should match /--default-ulimit nproc=/ } 
      #its(:args) { should match /--default-ulimit nofile=/ } 
    end

  end


end

