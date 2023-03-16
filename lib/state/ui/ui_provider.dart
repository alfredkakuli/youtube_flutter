import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UiProvider with ChangeNotifier {
  bool isDarkmode = false;
  bool isSidebarActive = false;
  Map logedUser = {};
  Map? alert;

  setLogedUser(userData) {
    logedUser = userData;
    notifyListeners();
  }

  setAlert(alertData) {
    if (alertData != null) {
      alert = json.decode(alertData);
    } else {
      alert = null;
    }

    notifyListeners();
  }

  get getLogedUser => logedUser;

  Map? getgetAlert() {
    return alert;
  }

  setSidebar(bool status) {
    isSidebarActive = status;
    notifyListeners();
  }

  get getSidebar => isSidebarActive;

  void toggleTheme() {
    isDarkmode = !isDarkmode;
    notifyListeners();
  }

  get getThemeMode => isDarkmode;
}
