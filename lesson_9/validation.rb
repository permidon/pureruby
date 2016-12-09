module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(name, type, *param)
      @checks ||= []
      @checks << { type: type, name: name, param: param }
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
        send check[:type], check[:name], check[:param]
      end
      true
    end

    def presence(name, _arg)
      raise "Value must be a non-empty string" if instance_variable_get("@#{name}").class != String || instance_variable_get("@#{name}").empty?
    end

    def format(name, reg)
      raise "Value must be in #{reg[0]} format" if instance_variable_get("@#{name}") !~ reg[0]
    end

    def type(name, type)
      raise "Value does not match to a given class" if instance_variable_get("@#{name}").class != type[0]
    end
  end
end
