class Car

  include Manufacture
  include InstanceCounter

  attr_reader :id
  attr_accessor :bound

  def initialize(id, plc_vol)
    add_instance
    @id = id
    @bound = 0 # Используется для определения занят вагон или нет
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Номер вагона должен быть строкой из 3-х символов" if id.class != String || id.size != 3
    true
  end

end
