# tests-docker-hardening

require 'spec_helper.rb'

#
# -- Tests for Docker Host Configuration, Audit-related checks only
#
describe '1 - Host Configuration', :if => dh_enabled?('1') do

  describe linux_audit_system do
    it { should be_enabled }
    it { should be_running }
  end

  describe '1.8 - Audit Docker Daemon', :if => dh_enabled?('1.8') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/usr\/bin\/docker.*-k docker/) }
    end
  end

  describe '1.9 - Audit Docker Files and Directories', :if => dh_enabled?('1.9') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/var\/lib\/docker.*-k docker/) }
    end
  end

  describe '1.10 - Audit Docker Files and Directories', :if => dh_enabled?('1.10') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/etc\/docker.*-k docker/) }
    end
  end

  # systemd only
  describe '1.11 - Audit Docker Files and Directories - docker-registry on systemd', :if => dh_enabled?('1.11') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/usr\/lib\/systemd\/system\/docker-registry\.service.*-k docker/) }
    end
  end
  
  # systemd only
  describe '1.12 - Audit Docker Files and Directories - docker.service on systemd', :if => dh_enabled?('1.12') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/usr\/lib\/systemd\/system\/docker\.service.*-k docker/) }
    end
  end

  describe '1.13 - Audit Docker Files and Directories - docker socket', :if => dh_enabled?('1.13') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/var\/run\/docker\.sock.*-k docker/) }
    end
  end

  describe '1.14 - Audit Docker Files and Directories - sysconfig/docker', :if => dh_enabled?('1.14') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/etc\/sysconfig\/docker.*-k docker/) }
    end
  end

  describe '1.15 - Audit Docker Files and Directories - sysconfig/docker-network', :if => dh_enabled?('1.15') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/etc\/sysconfig\/docker-network.*-k docker/) }
    end
  end

  describe '1.16 - Audit Docker Files and Directories - sysconfig/docker-registry', :if => dh_enabled?('1.16') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/etc\/sysconfig\/docker-registry.*-k docker/) }
    end
  end

  describe '1.17 - Audit Docker Files and Directories - sysconfig/docker-storage', :if => dh_enabled?('1.17') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/etc\/sysconfig\/docker-registry.*-k docker/) }
    end
  end

  describe '1.18 - Audit Docker Files and Directories - defaults', :if => dh_enabled?('1.18') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/etc\/default\/docker.*-k docker/) }
    end
  end
  

end
