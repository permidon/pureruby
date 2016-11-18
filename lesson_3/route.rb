class Route

  attr_reader :first, :last, :list

  def initialize(first, last)
    @first, @last = first, last
    @list = [first, last]
  end

  def add(station)
      if @list.include?(station)
      puts "Такая станция уже есть в маршруте"
    else
      @list.insert(-2, station)
    end
  end

  def del(station)
    if station == @list.first || station == @list.last
      puts "Вы не можете удалять начальную или конечную станцию"
    else
      @list.delete(station)
    end
  end

end
