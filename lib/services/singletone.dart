import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/dio_client.dart';
import '../data/sharedPreferences/shared_preferences.dart';


final getIt = GetIt.instance;

Future setup() async {
  final preferenceInstance = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesHelper>(SharedPreferencesHelper(preferences: preferenceInstance));
  getIt.registerSingleton<DioClient>(DioClient());

}
