import 'package:konter_gps/data/api.dart';
import 'package:konter_gps/data/dio.dart';
import 'package:dio/dio.dart' as dio;

late API _api;
late Dio _dio;

class Repo {
  late GpsCell gpsCell;

  Repo() {
    gpsCell = GpsCell();
    _api = API();
    _dio = Dio();
  }
}

class GpsCell {
  Catalog catalog = Catalog();
}

class Catalog {
  Future<dio.Response> listCatalog(int page) async {
    return await _dio.get(url: _api.smartphone.catalog, param: {"page": page});
  }
}
