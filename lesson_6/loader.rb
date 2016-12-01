# Файл для быстрой загрузки всех классов и модулей в irb

require_relative "manufacture.rb"
require_relative "instance_counter.rb"
require_relative "station.rb"
require_relative "route.rb"
require_relative "car.rb"
require_relative "train.rb"
require_relative "cargo_car.rb"
require_relative "cargo_train.rb"
require_relative "passenger_car.rb"
require_relative "passenger_train.rb"

msk = Station.new("MSK")
spb = Station.new("SPB")
r1 = Route.new(msk, spb)
t1 = PassengerTrain.new("111-11")
t2 = PassengerTrain.new("22222")
t3 = CargoTrain.new("AAA-AA")
t4 = CargoTrain.new("BBBBB")
