class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains << train
  end

  def departure(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      "Такого поезда нет на станции"
    end
  end

  def trains(type="all")
    @trains.map{|train| train if train.type == type || type == "all"}.compact
  end

end
