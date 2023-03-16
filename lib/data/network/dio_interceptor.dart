import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:full_screen_app/data/sharedprefrence/shared_preference_helper.dart';
import 'package:full_screen_app/services/singletone.dart';

class DioInterceptor extends Interceptor {
  final _preferences = getIt.get<SharedPreferencesHelper>();
  Map? alert = {'text': "", "type": "error"};
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _preferences.removeAlertInfo();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      alert = {"text": response.data['message'].toString(), "type": "success"};
      _preferences.setAlert(json.encode(alert));
    }
    super.onResponse(response, handler);
  }

  @override
  onError(DioError e, ErrorInterceptorHandler handler) {
    final decodededError = json.decode(e.response.toString());

    if (e.response?.statusCode == 401) {
      alert = {"text": decodededError['message']['errors']['message'].toString(), "type": "error"};
    }

    if (e.response?.statusCode == 404) {
      alert = {"text": decodededError['message'].toString(), "type": "error"};
    }
    if (e.response?.statusCode == 422) {
      alert = {"text": decodededError['message']["errors"].toString().replaceAll("[", "").replaceAll("]", ""), "type": "error"};
    }

    _preferences.setAlert(json.encode(alert));

    if (e.type == DioErrorType.badResponse) {
      // print("error=" + error.toString());
    }
    if (e.type == DioErrorType.connectionTimeout) {
      // print("errorrrrr" + e.toString());
      return;
    }
    if (e.type == DioErrorType.receiveTimeout) {
      // print("errorrrrr" + e.toString());
      return;
    }

    if (e.type == DioErrorType.unknown) {
      // print("errorrrrr" + e.toString());
      return;
    }
    super.onError(e, handler);
  }
}
