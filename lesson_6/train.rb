class Train

  include Manufacture
  include InstanceCounter

  attr_reader :id, :type, :cars, :speed
  attr_accessor :route

  ID_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  @@all_trains = {}

  def initialize(id)
    add_instance
    @id = id # Номер поезда
    validate!
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
    @speed
  end

  def stop
    if stopped?
      Puts "Поезд уже остановлен!"
    else
      @speed = 0
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

  def valid?
    validate!
  rescue
    false
  end

# Данные методы помещены в protected, т.к. используются только внутри класса для проверки:

protected

  def validate!
    raise "Номер поезда должен содержать символы" if id == ''
    raise "Формат номера поезда указан неверно" if id !~ ID_FORMAT
    true
  end

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
