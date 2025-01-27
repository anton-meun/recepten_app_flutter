import 'package:dio/dio.dart';

final dio = Dio(
    BaseOptions(baseUrl: 'https://themealdb.com/api/json/v1/1'),
);