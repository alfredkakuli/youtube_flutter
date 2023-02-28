import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider with ChangeNotifier {
  bool isDarkmode = false;
  bool isSidebarActive = false;
  Map logedUser = {};

  setSidebar(bool status) {
    isSidebarActive = status;
    notifyListeners();
  }

  setLogedUser() async {
    final userinfo = await SharedPreferences.getInstance();
    final String? logedInUser = userinfo.getString('user');
    if (logedInUser != null) {
      logedUser = json.decode(logedInUser);
    }
    notifyListeners();
  }

  get getSidebar => isSidebarActive;
  get getLogedUser => logedUser;

  void toggleTheme() {
    isDarkmode = !isDarkmode;
    notifyListeners();
  }

  get getThemeMode => isDarkmode;
}
