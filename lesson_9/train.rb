class Train
  include Manufacture
  include InstanceCounter
  include Validation

  attr_reader :id, :cars, :speed
  attr_accessor :route, :bound

  TRAIN_ID_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  validate :id, :presence
  validate :id, :format, TRAIN_ID_FORMAT

  @@all_trains = {}

  def initialize(id)
    add_instance
    @id = id
    validate!
    @cars = []
    @speed = 0
    @bound = 0 # Indicator of train condition
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
    @cars.each { |block| yield(block) }
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
    prev!
    @route.list[@current_station_id - 1]
  end

  def list
    @route.list
  end

  def move_next
    return unless route? && next_station # self.next_station
    @current_station_id += 1
  end

  def move_back
    return unless route? && previous_station # self.previous_station
    @current_station_id -= 1
  end

  # These methods are in protected section in order to use inside class only

  protected

  def stopped?
    raise "The train is stopped!" if @speed.zero?
    true
  end

  def route?
    @route ? true : false
  end

  def stop!
    raise "First, you have to stop the train" if @speed != 0
    true
  end

  def type!
    raise "Car is not 'Car' superclass object" if @car.class.superclass != Car
    raise "Car type does not match the type of train" if type != @car.type
    true
  end

  def car_validate!
    raise "The train already has this car" if @cars.include?@car
    raise "Some train already has this car" if @car.bound == 1
    true
  end

  def find!
    raise "Train №'#{@id}'' is not exist" if @@all_trains.key?!@id
    true
  end

  def del!
    raise "The train has no cars" if @cars.empty?
    true
  end

  def next!
    raise "This station is last" if @current_station_id == @route.list.size
    true
  end

  def prev!
    raise "This station is first" if @current_station_id.zero?
    true
  end
end
