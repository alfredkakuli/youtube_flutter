import 'package:flutter/cupertino.dart';
import 'package:full_screen_app/state/ui/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth/auth_provider.dart';

final List<SingleChildWidget> baseProvider = [
  ChangeNotifierProvider.value(value: UiProvider()),
  ChangeNotifierProvider.value(value: AuthProvider()),
];
