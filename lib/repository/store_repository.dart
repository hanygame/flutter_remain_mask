import 'dart:convert';
import 'package:fluttermaskapp/model/store.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

class StoreRepository {
  final _distance = Distance();

  Future<List<Store>> fetch(num lat, num lng) async {
    final stores = List<Store>();

    var url =
        'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=$lat&lng=$lng&m2000';

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {

        print(lng);

        final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
        final jsonStores = jsonResult['stores'];

        print(jsonStores);

        jsonStores.forEach((e) {
          final store_info = Store.fromJson(e);
          final store_distance = _distance.as(LengthUnit.Meter,
              LatLng(store_info.lat, store_info.lng), LatLng(lat, lng));
          store_info.distance = store_distance;
          stores.add(store_info);
        });
        print('Fetch 완료');

        return stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).toList()
          ..sort((a, b) => a.distance.compareTo(b.distance));
      } else {
        return [];
      }
    } catch (ex) {
      return [];
    }
  }
}
