import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:konter_gps/data/api.dart';

class Dio {
  late d.Dio _dio;

  Dio({Map<String, dynamic>? header}) {
    _dio = d.Dio();
    _dio.options = d.BaseOptions(
        baseUrl: API.baseUrl,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        responseType: ResponseType.json,
        headers: header ??
            {
              "Accept": "application/json",
              "Content-Type": "application/json",
            });
    _dio.interceptors.add(
      d.InterceptorsWrapper(
          onRequest: (d.RequestOptions o, d.RequestInterceptorHandler h) =>
              h.next(o),
          onResponse: (d.Response r, d.ResponseInterceptorHandler h) =>
              h.next(r),
          onError: (d.DioError e, d.ErrorInterceptorHandler h) async {
            if (e.response?.statusCode == 401) {
              //backtoroot
            }
            return h.next(e);
          }),
    );
  }
  Future get({
    required String url,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: param,
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error(e);
    } on SocketException catch (e) {
      print(e);
      return Future.error(e);
    } on d.DioError catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
