import 'package:flutter/material.dart';

import '../views/pages/auth/login.dart';
import '../views/pages/auth/register.dart';
import '../views/pages/home.dart';

final routes = {
  '/login_page': (BuildContext context) => const LoginScreen(),
  '/register_page': (BuildContext context) => const RegisterScreen(),
  '/home': (BuildContext context) => const MyHomePage(),
};
