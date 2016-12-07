class Route
  attr_reader :first, :last, :list

  def initialize(first, last)
    @first = first
    @last = last
    validate!
    @list = [first, last]
  end

  def add(station)
    @a_station = station
    add_validate!
    @list.insert(-2, station)
  end

  def del(station)
    @d_station = station
    del_validate!
    @list.delete(station)
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "First station isn't a Station-class object" if first.class != Station
    raise "Last station isn't a Station-class object" if last.class != Station
    true
  end

  def add_validate!
    raise "Station isn't a Station-class object" if @a_station.class != Station
    raise "The route already has this station" if @list.include?(@a_station)
    true
  end

  def del_validate!
    raise "You can not remove first station" if @d_station == @list.first
    raise "You can not remove last station" if @d_station == @list.last
    true
  end
end
