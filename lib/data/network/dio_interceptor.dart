import 'dart:convert';

import 'package:dio/dio.dart';

import '../../services/singletone.dart';
import '../sharedPreferences/shared_preferences.dart';

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

    if (e.type == DioErrorType.badResponse) {}
    if (e.type == DioErrorType.connectionTimeout) {
      return;
    }
    if (e.type == DioErrorType.receiveTimeout) {
      return;
    }

    if (e.type == DioErrorType.unknown) {
      return;
    }
    super.onError(e, handler);
  }
}
