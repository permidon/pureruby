module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(name, type, *params)
      @checks ||= []
      @checks << { type: type, name: name, params: params }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue
      false
    end

    protected

    def validate!
      self.class.checks.each do |check|
        ins = instance_variable_get("@#{check[:name]}")
        send check[:type], check[:name], check[:params], ins
      end
      true
    end

    def presence(name, _arg, ins)
      raise "Value must not be nil or empty" if ins.nil? || ins.to_s.empty?
    end

    def format(name, reg, ins)
      raise "Value must be in #{reg[0]} format" if ins !~ reg[0]
    end

    def type(name, type, ins)
      raise "Value does not match to a given class" if ins.class != type[0]
    end
  end
end
