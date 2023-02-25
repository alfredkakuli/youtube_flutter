import 'package:flutter/material.dart';
import 'package:full_screen_app/views/pages/home.dart';
import '../auth/login.dart';
import '../auth/register.dart';

final routes = {
  '/login_page': (BuildContext context) => const LoginScreen(),
  '/register_page': (BuildContext context) => const RegisterScreen(),
  '/home': (BuildContext context) => const MyHomePage(),
};
