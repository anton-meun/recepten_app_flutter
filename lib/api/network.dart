import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final dio = Dio(
    BaseOptions(baseUrl: 'https://themealdb.com/api/json/v1/1'),
);

String get apiUrl {
    if (kIsWeb) {
        // if the app runs on the web use:
        return 'http://localhost:5223/api';
    } else {
        // use for android
        return 'http://10.0.2.2:5223/api';
    }
}