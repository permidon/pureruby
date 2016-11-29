class PassengerCar < Car

  attr_reader :type

  def initialize(id)
    super
    @type = "сoach"
  end

end
