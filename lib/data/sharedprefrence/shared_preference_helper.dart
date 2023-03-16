import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences preferences;
  SharedPreferencesHelper({required this.preferences});

  Future setUserData({required Map data}) async {
    _storeUserInfo(data);
    return data;
  }

  setAlert(alert) {
    final alertInfo = preferences;
    alertInfo.setString('alertInfo', json.encode(alert).toString());
  }

  void _storeUserInfo(decodedResposnse) async {
    final accessToken = decodedResposnse['data']['access_token'].toString();
    final refreshToken = decodedResposnse['data']['refresh_token'].toString();
    final userId = decodedResposnse['data']['user']['id'].toString();
    var expiryTime = DateTime.now().add(Duration(seconds: int.parse(decodedResposnse['data']['expires_in'].toString())));

    // debugPrint(DateTime.now().toLocal().toString(), wrapWidth: 1024);

    final userInfo = preferences;
    Map<String, dynamic> user = decodedResposnse['data']['user'];
    user.putIfAbsent('expiry_time', () => expiryTime.toLocal().toIso8601String());
    user.putIfAbsent('user_id', () => userId);
    user.putIfAbsent('access_token', () => accessToken);
    user.putIfAbsent('refresh_token', () => refreshToken);
    userInfo.setString('authData', json.encode(user));

    // debugPrint(preferences.getString('authData').toString(), wrapWidth: 1024);
  }

  String? getAuthData() {
    return preferences.getString('authData');
  }

  String? getAlertInfo() {
    return preferences.getString('alertInfo');
  }

  void removeAlertInfo() async {
    preferences.remove('alertInfo');
  }

  void removeUserInfo() async {
    preferences.remove('authData');
  }
}
