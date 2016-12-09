class Station
  include Validation

  attr_reader :name

  validate :name, :presence

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
    @train.bound = 1
    @trains << train
  end

  def departure(train)
    @train = train
    exist!
    dep_validate!
    @train.bound = 0
    @trains.delete(train)
  end

  def trains(type = :all)
    @trains.map { |train| train if train.type == type || type == :all }.compact
  end

  def trains_block
    @trains.each { |block| yield(block) }
  end

  protected

  def exist!
    raise "Arg isn't a Train-superclass obj" if @train.class.superclass != Train
    true
  end

  def arr_validate!
    raise "This train is already at this station" if @trains.include?(@train)
    raise "This train is already at some station" if @train.bound == 1
    true
  end

  def dep_validate!
    raise "This train is not at this station" if @trains.include?!@train
    true
  end
end
