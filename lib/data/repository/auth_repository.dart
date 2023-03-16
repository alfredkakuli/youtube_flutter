import 'dart:async';
import 'package:full_screen_app/data/endpoints/endpoints.dart';
import 'package:full_screen_app/services/singletone.dart';
import '../network/dio_client.dart';

class AuthRepository {
  final _dio = getIt.get<DioClient>();

  Future<Map<String, dynamic>> login(data) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    final response = await _dio.dio.post(EndPoint.loginUrl, data: data);
    completer.complete(response.data);
    return completer.future;
  }

  Future<Map<String, dynamic>> register(data) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    final response = await _dio.dio.post(EndPoint.registerUrl, data: data);
    completer.complete(response.data);
    return completer.future;
  }
}
