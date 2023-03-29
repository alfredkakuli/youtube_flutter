import 'package:flutter/material.dart';

void navigator(BuildContext context, routeName) {
  Future.delayed(const Duration(seconds: 0), () {
    Navigator.pushNamed(context, routeName);
  });
}
