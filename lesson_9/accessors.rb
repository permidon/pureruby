module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      hist = "@#{name}_hist".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(hist, []) unless instance_variable_get(hist)
        instance_variable_set(var_name, value)
        instance_variable_get(hist) << instance_variable_get(var_name)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(hist) }
    end
  end

  def strong_attr_acessor(name, cls)
    var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise "Var does not match the specified class" if !value.is_a?(cls)
        instance_variable_set(var_name, value)
      end
  end
end

#EXAMPLE
# #
# class Test
#   extend Accessors

#   attr_accessor_with_history :a, :b
#   strong_attr_acessor :str, String
# end

# # obj = Test.new
# => #<Test:0x007fa05a8959c0>
# obj.a = 3
# => 3
# obj.a = 5
# => 5
# obj.a = 7
# => 7
# obj.b = "y"
# => "y"
# obj.b = 8
# => 8
# obj.a_history
# => [3, 5, 7]
# obj.b_history
# => ["y", 8]
# obj.str = 5
# RuntimeError: Var does not match the specified class
# obj.str = "5"
# => "5"
