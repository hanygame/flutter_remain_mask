import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttermaskapp/model/store.dart';
import 'package:fluttermaskapp/repository/location_repository.dart';
import 'package:fluttermaskapp/repository/store_repository.dart';

//with는 상속
class StoreViewModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreViewModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();

    stores =
    await _storeRepository.fetch(position.latitude, position.longitude);
    isLoading = false;
    //통지함
    notifyListeners();
  }
}
