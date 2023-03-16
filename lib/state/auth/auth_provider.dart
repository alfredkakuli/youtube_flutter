import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_screen_app/data/repository/auth_repository.dart';
import 'package:full_screen_app/navigation/router.dart';
import 'package:full_screen_app/services/singletone.dart';

import '../../data/sharedprefrence/shared_preference_helper.dart';

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

      // print("sssssss" + response['status'].toString());

      // navigator  ( BuildContext context '/login_page')

      // return response['status'];
      // debugPrint(response["data"]["user"].toString(), wrapWidth: 1024);
      // if (response['status'] == true) {
      //   // return true;
      //   await singleTone.setUserData(data: response).then(
      //         (value) => userData = value,
      //       );
      // } else {
      //   return false;
      // }
    } catch (e) {
      status = false;
      // debugPrint(e.toString());
    }
    updateProceed(status);
    return status;
  }
}
