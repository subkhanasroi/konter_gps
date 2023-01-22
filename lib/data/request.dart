import 'package:konter_gps/data/repo.dart';
import 'package:dio/dio.dart' as dio;

late Repo _repo;

class Request {
  late GpsCell gpsCell;

  Request() {
    gpsCell = GpsCell();
    _repo = Repo();
  }
}

class GpsCell {
  Catalog catalog = Catalog();
}

class Catalog {
  Future<dio.Response> listCatalog({required int page}) {
    return _repo.gpsCell.catalog.listCatalog(page);
  }
}
