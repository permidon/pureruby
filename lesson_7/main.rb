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
    @cars = []
  end

  # Основное меню
  def menu
    puts
    puts "Выберите, что вы хотите сделать, и введите соответствующий номер:"
    puts
    puts "1.  Создать станцию"
    puts "2.  Создать поезд"
    puts "3.  Создать вагон"
    puts "4.  Занять место или объем в вагоне"
    puts "5.  Прицепить вагон"
    puts "6.  Отцепить вагон"
    puts "7.  Показать список вагонов поезда"
    puts "8.  Поместить поезд на станцию"
    puts "9.  Показать список станций"
    puts "10. Показать список поездов на станции"
    puts "11. Выход из программы"
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
      when 3
        begin
          create_car
        rescue => e
          puts e.message
          retry
        end
      when 4
        begin
          pack_car
        rescue => e
          puts e.message
          retry
        end
      when 5
        begin
          add_cars
        rescue => e
          puts e.message
          retry
        end
      when 6
        begin
          del_cars
        rescue => e
          puts e.message
          retry
        end
      when 7
        cars_list
      when 8
        begin
          move_train
        rescue => e
          puts e.message
          retry
        end
      when 9
        stations
      when 10
        trains_list
      when 11
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
      if station?(stn)
        @stations.each do |item|
          if item.name == stn
            puts "Поезда, находящиеся на станции:"
            item.trains_block do |train|
              puts "Поезд №#{train.id}, тип '#{train.type}', количество вагонов - #{train.cars.size}"
            end
          end
        end
      else
        puts "Cтанции '#{stn}' не существует"
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
    t_id = gets.chomp

    if train?(t_id)
      puts "Поезд '#{t_id}' уже существует"
    else
      if type == "coach"
        train = PassengerTrain.new(t_id)
      else
        train = CargoTrain.new(t_id)
      end
      @trains << train
      puts "Поезд №#{t_id} типа '#{type}' создан"
    end
    menu
  end

  # проверка существования поезда
  def train?(t_id)
    result = false
    @trains.each do |i|
    result = true if i.id == t_id
    end
    result
  end

  # Добавляем вагон к поезду
  def add_cars
    if zero_trains!
      puts "Введите номер поезда: "
      t_id = gets.chomp
      if train?(t_id)
        @trains.each do |i|
          if i.id == t_id
            puts "Введите номер вагона: "
            id = gets.chomp
            if car?(id)
              @cars.each do |j|
                if j.id == id
                  if i.type == j.type
                    i.add_car(j)
                    puts "Поезду №#{i.id} добавлен вагон №#{j.id}"
                    puts "Вагоны поезда: #{i.cars}"
                  else
                    puts "Тип вагона не совпадает с типом поезда"
                  end
                end
              end
            else
              "Вагона №#{id} не существует"
            end
          end
        end
      else
        puts "Поезда №#{t_id} не существует"
      end
    end
    menu
  end

  # Отцепляем вагон
  def del_cars
    if zero_trains!
      puts "Введите номер поезда: "
      t_id = gets.chomp
      if train?(t_id)
        @trains.each do |i|
          if i.id == t_id
            if i.cars.size > 0
              i.del_car
              puts "У поезда №#{t_id} отцеплен один вагон. Осталось #{i.cars.size} вагонов"
            else
              puts "У поезда №#{t_id} нет вагонов."
            end
          end
        end
      else
        puts "Поезда №#{t_id} не существует"
      end
    end
    menu
  end

  # Перемещение поезда
  def move_train
    if zero_stn! && zero_trains!
      print "Введите название станции: "
      stn = gets.chomp
      if station?(stn)
        @stations.each do |station|
          if station.name == stn
            puts "Введите номер поезда: "
            t_id = gets.chomp
            if train?(t_id)
              @trains.each do |train|
                if train.id == t_id
                  station.arrival(train)
                  puts "Поезд помещен на станцию"
                end
              end
            else
              puts "Поезда №#{t_id} не существует"
            end
          end
        end
      else
        puts "Станции '#{stn}' не существует"
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

  # Создание вагона
  def create_car
    puts "Выберите тип вагона: "
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
        create_car
    end

    print "Введите номер вагона в формате XXX: "
    id = gets.chomp

    if car?(id)
      puts "Вагон №#{id} уже существует"
    else
      if type == "coach"
        puts "Введите количество мест в вагоне: "
        places = gets.to_i
        car = PassengerCar.new(id, places)
        puts "Вагон №#{id} типа '#{type}' создан. Количество мест - #{places}"
      else
        puts "Введите объем вагона: "
        volume = gets.to_i
        car = CargoCar.new(id, volume)
        puts "Вагон №#{id} типа '#{type}' создан. Объем - #{volume}"
      end
      @cars << car
    end
    menu
  end

  # проверка существования вагона
  def car?(id)
    result = false
    @cars.each do |i|
    result = true if i.id == id
    end
    result
  end

  # занимаем место или объем
  def pack_car
    if zero_trains!
      puts "Введите номер вагона в формате XXX: "
      id = gets.chomp

      if car?(id)
        @cars.each do |car|
          if car.id == id
            if car.type == "coach"
              if car.free == 0
                puts "Свободных мест нет"
                menu
              else
                car.take_place
                puts "В вагоне занято мест - #{car.taken}, свободно - #{car.free}"
              end
            else
              if car.free == 0
                puts "Свободного объема нет"
                menu
              else
                puts "Введите заполняемый объем: "
                content = gets.to_i
                car.fill_vol(content)
                puts "В вагоне заполнен объем - #{car.filled}, осталось #{car.free}"
              end
            end
          end
        end
      else
        puts "Вагон №#{id} не существует"
      end
    end
    menu
  end

  # Проверка на отсутствие поездов
  def zero_trains!
    if @trains.size == 0
      puts "Еще не создано ни одного поезда"
      false
    else
      true
    end
  end

  # Список вагонов поезда
  def cars_list
    if zero_trains!
      print "Введите номер поезда: "
      trn = gets.chomp
      if train?(trn)
        @trains.each do |item|
          if item.id == trn
            puts "Вагоны поезда #{trn}:"
            if item.type == "coach"
              item.cars_block do |car|
                puts "Вагон №#{car.id}, тип '#{car.type}'. Места: свободно - #{car.free}, занято - #{car.taken}"
              end
            else
              item.cars_block do |car|
                puts "Вагон №#{car.id}, тип '#{car.type}'. Сбъем: свободно - #{car.free}, занято - #{car.filled}"
              end
            end
          end
        end
      else
        puts "Поезд №#{trn} не существует"
      end
    end
    menu
  end

end

management = Main.new
management.menu
