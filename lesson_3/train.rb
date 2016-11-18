class Train

  attr_reader :number, :type, :car, :speed
  attr_accessor :route

  def initialize(number, type, car = 0)
    @number = number
    @type = type
    @car = car
    @speed = 0
    @current_station_id = 0
  end

  def speed_up(speed)
    @speed += speed if speed > 0
  end

  def stop
    @speed = 0
  end

  def add_car
    if @speed > 0
      puts "Сначала необходимо остановить поезд"
    else
      @car += 1
    end
  end

  def del_car
    if @speed > 0
      puts "Сначала необходимо остановить поезд"
    elsif @car == 0
      puts "Поезд не содержит вагонов"
    else
      @car -= 1
    end
  end

  def current_station
    @route.list[@current_station_id]
  end

  def previous_station
    @route.list[@current_station_id - 1] if @current_station_id > 0
  end

  def next_station
    @route.list[@current_station_id + 1] if @current_station_id < @route.list.size
  end

  def list
    @route.list
  end

  def move_next
    @current_station_id += 1 if @current_station_id < @route.list.size
  end

  def move_back
    @current_station_id -= 1 if @current_station_id > 0
  end

end
