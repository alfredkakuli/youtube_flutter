import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/sharedPreferences/shared_preferences.dart';
import '../../services/singletone.dart';

class AuthProvider extends ChangeNotifier {

  final AuthRepository authRepository = AuthRepository();
  
  final singleTone = getIt.get<SharedPreferencesHelper>();

  Map userData = {};
  bool proceed = false;

  void updateProceed(isSafeToProceed) {
    proceed = isSafeToProceed;
    notifyListeners();
  }

  get getProceed => proceed;

  Future login(data) async {
    try {
      final response = await authRepository.login(data);
      // debugPrint(response["data"]["user"].toString(), wrapWidth: 1024);
      if (response['status'] == true) {
        await singleTone.setUserData(data: response).then(
              (value) => userData = value,
            );
      } else {
        return false; 
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future register(data) async {
    bool status = true;
    try {
      final response = await authRepository.register(data);
    } catch (e) {
      status = false;
      // debugPrint(e.toString());
    }
    updateProceed(status);
    return status;
  }
}
