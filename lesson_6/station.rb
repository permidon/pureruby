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
    @trains << train
  end

  def departure(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts "Такого поезда нет на станции"
    end
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
    raise "Название станции должено содержать символы" if name == ''
    true
  end

end
