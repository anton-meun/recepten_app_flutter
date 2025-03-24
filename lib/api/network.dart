import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

final dio = Dio(
    BaseOptions(baseUrl: 'https://themealdb.com/api/json/v1/1'),
);

String get apiUrl {
    // Use kIsWeb with the same URL as 'else' because 'dart:io' is not available on the web.
    if (kIsWeb) {
        // use for web
        return 'http://localhost:5223/api';
    } else if (Platform.isAndroid) {
        // if the app android, is a Bridge for localhost:
        return 'http://10.0.2.2:5223/api';
    } else {
        // use for web and windows
        return 'http://localhost:5223/api';
    }
}