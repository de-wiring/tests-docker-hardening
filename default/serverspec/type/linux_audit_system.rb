

include Serverspec::Type

module Serverspec
  module Type
    class LinuxAuditSystem < Base
      def initialize()
        @name = 'linux_audit_system' 
        @runner = Specinfra::Runner
        @rules_content = nil
      end

      def to_s
        type = self.class.name.split(':')[-1]
        type.gsub!(/([a-z\d])([A-Z])/, '\1 \2')
        type.capitalize!
        type
      end

      def has_audit_rule?(rule)
        if rule.instance_of?(Regexp)
          return get_rules.any? { |r| r.match(rule) }
        end
        get_rules.any? { |r| r == rule }
      end

      def enabled?
        get_status('enabled') == '1'
      end

      def running?
        pid = get_status('pid') 
        ( pid != nil && pid.size > 0 && pid != '0' )
      end

private 
      def get_rules
        if @rules_content.nil?
          @rules_content = @runner.run_command('auditctl -l').stdout.split("\n").map { |l| l.chomp }
        end
        @rules_content || []
      end

      def get_status(part)
        cmd = "auditctl -s | grep \"^#{part}\" | awk '{ print $2 }'"
        @runner.run_command(cmd).stdout.chomp
      end
    end

    def linux_audit_system
      LinuxAuditSystem.new
    end
  end
end

