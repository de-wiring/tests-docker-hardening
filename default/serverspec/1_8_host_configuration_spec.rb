# tests-docker-hardening

require 'spec_helper.rb'

# -- Tests for Docker Host Configuration
describe '1 - Host Configuration', :if => cis_enabled?('1') do

  describe linux_audit_system do
    it { should be_enabled }
    it { should be_running }
  end

  describe '1.8 - Audit docker daemon', :if => cis_enabled?('1.8') do
    describe linux_audit_system do
      it { should have_audit_rule(/-w \/usr\/bin\/docker.*-k docker/) }
    end
  end

end
