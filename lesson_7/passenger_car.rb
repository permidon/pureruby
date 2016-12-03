class PassengerCar < Car

  attr_reader :type, :taken, :free

  def initialize(id, places)
    super
    @type = "coach"
    @places = places
    valid!
    @taken = 0
    @free = places
  end

  def take_place
    raise "Все места в вагоне заняты" if @taken == @places
    @free = @places - @taken - 1
    # свободные добавлены выше, чтобы последним выводом было кол-во занятых мест
    @taken += 1
  end

  protected

  def valid!
    raise "Количество мест в вагоне должно быть целым числом" if @places.class != Fixnum
    raise "Количество мест находится в интервале от 1 до 100" if @places < 1 || @places > 100
    true
  end

end
