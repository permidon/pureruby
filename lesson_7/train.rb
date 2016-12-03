class Train

  include Manufacture
  include InstanceCounter

  attr_reader :id, :cars, :speed
  attr_accessor :route, :bound

  ID_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  @@all_trains = {}

  def initialize(id)
    add_instance
    @id = id # Номер поезда
    validate!
    @cars = []
    @speed = 0
    @bound = 0 # Используется для определения занят поезд или нет
    @current_station_id = 0
    @@all_trains[@id] = self
  end

  def self.find(id)
    @id = id
    find!
    @@all_trains[id]
  end

  def speed_up(speed)
    @speed += speed
    @speed
  end

  def stop
    stopped?
    @speed = 0
  end

  def add_car(car)
    @car = car
    stop!
    type!
    car_validate!
    @car.bound = 1
    @cars << car
  end

  def del_car
    stop!
    del!
    @cars.last.bound = 0
    @cars.pop
  end

  def cars_block
    @cars.each {|block| yield(block)}
  end

  def current_station
    return unless route?
    @route.list[@current_station_id]
  end

  def next_station
    return unless route?
    next!
    @route.list[@current_station_id + 1]
  end

  def previous_station
    return unless route?
    @route.list[@current_station_id - 1]
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
    raise "Номер поезда должен быть строкой и записан в формате 'XXX-XX'" if id.class != String || id.size == 0
    raise "Формат номера поезда указан неверно" if id !~ ID_FORMAT
    true
  end

  def stopped?
    raise "Поезд уже остановлен!" if @speed == 0
    true
  end

  def route?
    if @route
      true
    else
      false
    end
  end

  def stop!
    raise "Сначала необходимо остановить поезд" if @speed != 0
    true
  end

  def type!
    raise "Вагон не является объектом cуперкласса 'Car'" if @car.class.superclass != Car
    raise "Тип вагона не совпадает с типом поезда" if self.type != @car.type
    true
  end

  def car_validate!
    raise "Такой вагон уже есть у этого поезда" if @cars.include?(@car)
    raise "Такой вагон уже есть у какого-то поезда" if @car.bound == 1
    true
  end

  def find!
    raise "Поезда с таким номером не найдено" if @@all_trains.key?!(@id)
    true
  end

  def del!
    raise "Поезд не содержит вагонов" if @cars.size == 0
    true
  end

  def next!
    raise "Данная станция - последняя" if @current_station_id == @route.list.size
    true
  end

  def prev!
    raise "Данная станция - первая" if @current_station_id == 0
    true
  end

  def cars_list(block)

  end

end
