# Основная программа для исполнения
require_relative './railroad'

# тестовые данные (станции, поезда, вагоны).
# для проверки работоспособности новых методов
rr = RailRoad.new
[Station.new('ab'),
 Station.new('cd'),
 Station.new('de')].each { |obj| rr.stations << obj }

[TrainCargo.new('111-aa'),
 TrainCargo.new('112-as'),
 TrainPass.new('222-qw'),
 TrainPass.new('223-er')].each { |obj| rr.trains << obj }

[WagonCargo.new(100),
 WagonCargo.new(120),
 WagonCargo.new(80),
 WagonPass.new(54),
 WagonPass.new(55),
 WagonPass.new(56)].each { |obj| rr.wagons << obj }

rr.trains[0].add_wagon(rr.wagons[0])
rr.wagons.delete(rr.wagons[0])
rr.trains[0].add_wagon(rr.wagons[1])
rr.wagons.delete(rr.wagons[1])
rr.trains[0].add_wagon(rr.wagons[2])
rr.wagons.delete(rr.wagons[2])
rr.trains[2].add_wagon(rr.wagons[3])
rr.wagons.delete(rr.wagons[3])
rr.trains[0].speed = 70
rr.routes << Route.new(rr.stations[0], rr.stations[1])

rr.menu
