require_relative "manufacture"
require_relative "instance_counter"
require_relative "station"
require_relative "route"
require_relative "car"
require_relative "train"
require_relative "cargo_car"
require_relative "cargo_train"
require_relative "passenger_car"
require_relative "passenger_train"

class Main

  def initialize
    @stations = []
    @trains = []
  end

  # Основное меню
  def menu
    puts
    puts "Выберите, что вы хотите сделать, и введите соответствующий номер:"
    puts
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Добавить вагон"
    puts "4. Отцепить вагон"
    puts "5. Поместить поезд на станцию"
    puts "6. Список станций"
    puts "7. Список поездов на станции"
    puts "8. Выход из программы"
    puts
    print "Ваш вариант: "

    ans = gets.to_i

    case ans
      when 1
        begin
          create_station
        rescue => e
          puts e.message
          retry
        end
      when 2
        begin
          create_train
        rescue => e
          puts e.message
          retry
        end
      # Для следующих методов не использую вывод по raise, т.к. иначе,
      # при отсутствии созданных поездов или станций, мы попадаем
      # цикл из которого можно выйти только по Ctrl+C
      when 3
          add_cars
      when 4
          del_cars
      when 5
          move_train
      when 6
          stations
      when 7
          trains_list
      when 8
        puts "Программа завершена"
        exit
      else
        puts "Неправильный вариант. Повторите ввод"
        puts
        menu
    end
  end

  private

  # Создание станции
  def create_station
    print "Введите название станции: "
    station = gets.chomp

    raise "Станция уже сужествует" if station?(station)
    @stations << Station.new(station)
    puts "Станция '#{station}' создана"
    menu
  end

  # Проверка существования станции
  def station?(station)
    result = false
    @stations.each do |i|
    result = true if i.name == station
    end
    result
  end

  # Список станций:
  def stations
    if zero_stn!
      puts "Список станций в порядке создания:"
      @stations.each_with_index do |item, index|
        puts "#{index + 1} - #{item.name}"
      end
    end
    menu
  end

  # Список поездов на станции
  def trains_list
    if zero_stn!
      print "Введите название станции: "
      stn = gets.chomp
      @stations.each do |item|
        if item.name == stn
          puts "Поезда, находящиеся на станции:"
          item.trains
        else
          puts "Cтанции #{stn} не существует"
        end
      end
    end
    menu
  end

  # Создание поезда
  def create_train
    puts "Выберите тип поезда: "
    puts
    puts "1. Пассажирский"
    puts "2. Грузовой"
    puts
    print "Ваш вариант: "

    trn = gets.to_i

    case trn
      when 1
        type = "coach"
      when 2
        type = "cargo"
      else
        puts "Неправильный вариант. Повторите ввод"
        puts
        create_train
    end

    print "Введите номер поезда в формате XXX-XX: "
    id = gets.chomp

    if train?(id)
      puts "Поезд '#{id}' уже существует"
    else
      if type == "coach"
        train = PassengerTrain.new(id)
      else
        train = CargoTrain.new(id)
      end
      @trains << train
      puts "Поезд '#{id}' типа '#{type}' создан"
    end
    menu
  end

  # проверка существования поезда
  def train?(id)
    result = false
    @trains.each do |i|
      result = true if i.id == id
    end
    result
  end

  # Добавляем вагон к поезду
  def add_cars
    puts "Введите номер поезда: "
    id = gets.chomp
    if train?(id)
      @trains.each do |i|
        if i.id == id
          type = i.type
          cid = (999 - i.cars.size).to_s
          type == "coach" ? newcar = PassengerCar.new(cid) : newcar = CargoCar.new(cid)
          i.add_car(newcar)
          puts
          puts "Поезду '#{id}' добавлен вагон '#{cid}'"
          puts "Вагоны поезда: #{i.cars}"
        end
      end
    else
      puts "Поезда '#{id}' не существует"
    end
    menu
  end

  # Отцепляем вагон
  def del_cars
    puts "Введите номер поезда: "
    id = gets.chomp
    if train?(id)
      @trains.each do |i|
        if i.id == id && i.cars.size > 0
          i.del_car
          puts "У поезда '#{id}' отцеплен один вагон. Осталось #{i.cars.size} вагонов"
        else
          puts "У поезда '#{id}' нет вагонов."
        end
      end
    else
      puts "Поезда '#{id}' не существует"
    end
    menu
  end

  def method_name

  end

  # Перемещение поезда
  def move_train
    if zero_stn!
      print "Введите название станции: "
      stn = gets.chomp
      @stations.each do |station|
        if station.name == stn
          puts "Введите номер поезда: "
          tid = gets.chomp
          if train?(tid)
            @trains.each do |train|
              if train.id == tid
                puts "Поезд помещен на станцию"
                station.arrival(train)
              end
            end
          end
        else
          puts "Cтанции #{stn} не существует"
        end
      end
    end
    menu
  end

  # Проверка на отсутствие станций
  def zero_stn!
    if @stations.size == 0
      puts "Еще не создано ни одной станции"
      false
    else
      true
    end
  end

end

management = Main.new
management.menu


