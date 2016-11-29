class Car

  include Manufacture
  include InstanceCounter

  attr_reader :id

  def initialize(id)
    add_instance
    @id = id
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Номер вагона должен содержать символы" if id == ''
    true
  end

end
