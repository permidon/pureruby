class Car
  include Manufacture
  include InstanceCounter

  attr_reader :id
  attr_accessor :bound

  def initialize(id, _plc_vol)
    add_instance
    @id = id
    @bound = 0 # Indicator of car condition
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Number must be a string" if id.class != String
    raise "Number must be a 3-character string" if id.size != 3
    true
  end
end
