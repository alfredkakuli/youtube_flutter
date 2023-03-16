import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:full_screen_app/data/network/dio_interceptor.dart';

import '../../services/singletone.dart';
import '../sharedprefrence/shared_preference_helper.dart';

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
