class Train

  include Manufacture
  include InstanceCounter

  attr_reader :id, :type, :cars, :speed
  attr_accessor :route

  @@all_trains = {}

  def initialize(id)
    add_instance
    @id = id # Номер поезда
    @cars = []
    @speed = 0
    @current_station_id = 0
    @@all_trains[@id] = self
  end

  def self.find(id)
    @@all_trains.key?(id) ? @@all_trains[id] : puts('Поезда с таким номером не найдено')
  end

  def speed_up(speed)
    @speed += speed
    Puts "Текущая скорость #{@speed}"
  end

  def stop
    if stopped?
      Puts "Поезд уже остановлен!"
    else
      @speed = 0
      Puts "Поезд остановлен"
    end
  end

  def add_car(car)
    if stopped?
      if self.type == car.type
        @cars << car
      else
        puts "Тип вагона не совпадает с типом поезда"
      end
    else
      puts "Сначала необходимо остановить поезд"
    end
  end

  def del_car
    if stopped?
      if @cars.size > 0
        @cars.pop
      else
        puts "Поезд не содержит вагонов"
      end
    else
      puts "Сначала необходимо остановить поезд"
    end
  end

  def cars
    @cars
  end

  def current_station
    return unless route?
    @route.list[@current_station_id]
  end

  def next_station
    return unless route?
      if @current_station_id < @route.list.size
        @route.list[@current_station_id + 1]
      else
        puts "Данная станция - последняя"
      end
  end

  def previous_station
    return unless route?
      if @current_station_id > 0
        @route.list[@current_station_id - 1]
      else
        puts "Данная станция - первая"
      end
  end

  def list
    @route.list
  end

  def move_next
    return unless route? && self.next_station
    @current_station_id += 1
  end

  def move_back
    return unless route? && self.previous_station
    @current_station_id -= 1
  end

# Данные методы помещены в protected, т.к. используются только внутри класса для проверки:

protected

  def stopped?
    @speed == 0
  end

  def route?
    if @route
      true
    else
      puts "Поезд не имеет маршрута"
      false
    end
  end

end
