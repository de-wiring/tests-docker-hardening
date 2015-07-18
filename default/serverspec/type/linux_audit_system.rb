

include Serverspec::Type

# Serverspec module
module Serverspec
  # enhance type module
  module Type
    # LinuxAuditSystem is a resource type to query the linux audit
    # system via auditctl
    class LinuxAuditSystem < Base
      def initialize
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
          return rules.any? { |r| r.match(rule) }
        else
          return rules.any? { |r| r == rule }
        end
      end

      def enabled?
        status_of('enabled') == '1'
      end

      def running?
        pid = status_of('pid')
        (!pid.nil? && pid.size > 0 && pid != '0')
      end

      private

      def rules
        if @rules_content.nil?
          @rules_content = @runner
                           .run_command('auditctl -l')
                           .stdout.split("\n").map(&:chomp)
        end
        @rules_content || []
      end

      def status_of(part)
        cmd = "auditctl -s | grep \"^#{part}\" | awk '{ print $2 }'"
        @runner.run_command(cmd).stdout.chomp
      end
    end

    def linux_audit_system
      LinuxAuditSystem.new
    end
  end
end
