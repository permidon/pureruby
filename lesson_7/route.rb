class Route

  attr_reader :first, :last, :list

  def initialize(first, last)
    @first, @last = first, last
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
    raise "Первая станция не является объектом класса 'Station'" if first.class != Station
    raise "Последняя станция не является объектом класса 'Station'" if last.class != Station
    # raise "!!!-!!!" if defined?(last.class).nil? == true
    true
  end

  def add_validate!
    raise "Cтанция не является объектом класса 'Station'" if @a_station.class != Station
    raise "Такая станция уже есть в маршруте" if @list.include?(@a_station)
    true
  end

  def del_validate!
    raise "Вы не можете удалить начальную или конечную станцию" if @d_station == @list.first || @d_station == @list.last
    true
  end

end
