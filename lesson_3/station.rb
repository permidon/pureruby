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
    if @trains.size == 0
      puts "На станции нет поездов"
    else
      if type == "all"
        puts "Поезда всех типов, находящиеся на станции:"
        @trains.map { |train| train }
      else
        puts "Поезда типа '#{type}', находяшиеся на станции:"
        @trains.map do |train|
          if train.type == type
           train
          end
        end
      end
    end
  end

end
