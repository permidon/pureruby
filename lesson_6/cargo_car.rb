class CargoCar < Car

  attr_reader :type

  def initialize(id)
    super
    @type = "сargo"
  end

end
