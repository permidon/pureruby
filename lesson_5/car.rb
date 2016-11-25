class Car

  include Manufacture
  include InstanceCounter

  attr_reader :id

  def initialize(id)
    add_instance
    @id = id
  end

end
