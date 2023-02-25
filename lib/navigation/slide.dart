import 'package:flutter/material.dart';

class SlideLeft extends PageRouteBuilder {
  final Widget page;
  SlideLeft({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                  position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(primaryAnimation),
                  child: child,
                ));
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                  position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(primaryAnimation),
                  child: child,
                ));
}
