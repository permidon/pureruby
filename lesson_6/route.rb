class Route

  attr_reader :first, :last, :list

  def initialize(first, last)
    @first, @last = first, last
    @list = [first, last]
    validate!
  end

  def add(station)
      station_validate!
      if @list.include?(station)
      puts "Такая станция уже есть в маршруте"
    else
      @list.insert(-2, station)
    end
  end

  def del(station)
    if station == @list.first || station == @list.last
      puts "Вы не можете удалить начальную или конечную станцию"
    else
      @list.delete(station)
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Указанные станции не существует" if first.class != Station && last.class != Station
    raise "Первая станция не существует" if first.class != Station
    raise "Последняя станция не существует" if last.class != Station
    true
  end

end
