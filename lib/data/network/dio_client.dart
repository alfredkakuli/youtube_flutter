import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../services/singletone.dart';
import '../sharedPreferences/shared_preferences.dart';
import 'dio_interceptor.dart';

class DioClient {
  final _preferences = getIt.get<SharedPreferencesHelper>();
  String? accessToken;

  final _dio = Dio();
  Dio get dio => _dio;

  DioClient() {
    final decodedUser = json.decode(_preferences.getAuthData().toString());
    if (decodedUser != null) {
      accessToken = decodedUser['access_token'].toString();
    }
    _dio.options.headers = {
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
      HttpHeaders.acceptHeader: "json/application/json",
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
    };
    _dio.interceptors.add(DioInterceptor());
  }
}
