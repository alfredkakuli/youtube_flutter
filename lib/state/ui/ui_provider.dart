import 'package:flutter/cupertino.dart';

class UiProvider with ChangeNotifier {
  bool isDarkmode = false;
  bool isSidebarActive = false;

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
