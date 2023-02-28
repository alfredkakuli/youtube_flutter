import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_app/auth/login.dart';
import 'package:full_screen_app/state/provider_export.dart';
import 'package:full_screen_app/state/ui/ui_provider.dart';
import 'package:full_screen_app/theme/color_scheme.dart';
import 'package:full_screen_app/views/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/register.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final userinfo = await SharedPreferences.getInstance();
  final String? logedInUser = userinfo.getString('user');

  if (logedInUser != null) {
    final decodedUser = json.decode(logedInUser);
 
    final expiryTime = DateTime.parse(decodedUser['expiry_time']);
    if (expiryTime.isAfter(DateTime.now())) {
      runApp(const MyApp(
        isLogedIn: true,
      ));
    } else {
      userinfo.remove('user');
      runApp(const MyApp(
        isLogedIn: false,
      ));
    }
  } else {
    runApp(const MyApp(
      isLogedIn: false,
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, @required this.isLogedIn});
  final isLogedIn;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: baseProvider,
        child: Consumer<UiProvider>(builder: (_, baseUiProvider, _2) {
          baseUiProvider.setLogedUser();
          StatefulWidget home;
          if (isLogedIn) {
            home = const MyHomePage();
          } else {
            home = const LoginScreen();
          }

          var statusText = Brightness.light;
          var bgColor = darkModeprimarybg.withOpacity(0.00095);

          if (!baseUiProvider.getThemeMode) {
            statusText = Brightness.dark;
            lightModeSecondarybg.withOpacity(0.00095);
          }

          if (Platform.isAndroid || Platform.isIOS) {
            SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: statusText, systemNavigationBarIconBrightness: statusText, systemNavigationBarColor: bgColor, systemNavigationBarDividerColor: bgColor, systemNavigationBarContrastEnforced: false, systemStatusBarContrastEnforced: false);
            SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.bottom]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            themeMode: baseUiProvider.getThemeMode ? ThemeMode.dark : ThemeMode.light,
            // home: const MyHomePage(),
            // home: const LoginScreen(),
            home: home,
          );
        }));
  }
}
