class Station

  attr_reader :name

  @@all_stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self
  end

  def self.all
    @@all_stations
  end

  def arrival(train)
    @train = train
    exist!
    arr_validate!
    @trains << train
  end

  def departure(train)
    @train = train
    exist!
    dep_validate!
    @trains.delete(train)
  end

  def trains(type="all")
    @trains.map{|train| train if train.type == type || type == "all"}.compact
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Название станции должно быть строкой как минимум из 1-го символа" if name.class != String || name.size == 0
    true
  end

  def exist!
    raise "Поезд не является объектом cуперкласса 'Train'" if @train.class.superclass != Train
    true
  end

  def arr_validate!
    raise "Такой поезд уже есть на станции" if @trains.include?(@train)
    true
  end

  def dep_validate!
    raise "Такого поезда нет на станции" if @trains.include?!(@train)
    true
  end

end
