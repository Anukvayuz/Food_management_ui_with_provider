
import 'package:dio/dio.dart';

class API {
  Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = "https://www.themealdb.com/api/json/v1/1";
  }

  Dio get sendrequest => _dio;
}
