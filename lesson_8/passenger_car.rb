class PassengerCar < Car
  attr_reader :type, :taken, :free

  def initialize(id, places)
    super
    @type = :coach
    @places = places
    valid!
    @taken = 0
    @free = places
  end

  def take_place
    raise "All seats are taken" if @taken == @places
    @free = @places - @taken - 1
    @taken += 1
  end

  protected

  def valid!
    raise "Seats quantity must be an integer" if @places.class != Fixnum
    raise "Quantity must be in range 1-100" if @places < 1 || @places > 100
    true
  end
end
