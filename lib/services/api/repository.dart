import 'package:turbo_express/model/car.dart';
import 'package:turbo_express/model/car_type.dart';
import 'package:turbo_express/services/api/api.dart';

class ApiRepository {
  var _api = ApiService.getInstance();

  Future<List<Car>> get fetchCars => _api.getCars();

  Future<List<CarType>> get fetchCarTypes => _api.getCarTypes();
}
