class Car
  include Manufacture
  include InstanceCounter
  include Validation

  attr_reader :id
  attr_accessor :bound

  CAR_ID_FORMAT = /^[a-z0-9]{3}$/i

  validate :id, :presence
  validate :id, :format, CAR_ID_FORMAT

  def initialize(id, _plc_vol)
    add_instance
    @id = id
    @bound = 0 # Indicator of car condition
    validate!
  end
end
