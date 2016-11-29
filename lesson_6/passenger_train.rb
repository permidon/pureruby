class PassengerTrain < Train

  attr_reader :type

  def initialize(id)
    super
    @type = "сoach"
  end

end
