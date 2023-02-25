import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation_rotation;
  late Animation animation_radius_in;
  late Animation animation_radius_out;
  var radius = 15.0;
  var radius2 = 5.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation_rotation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));
    _controller.addListener(() {
      // _controller.repeat();
      setState(() {
        _controller.repeat();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Container(
      height: 50.0,
      width: 50.0,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(
                  radius * cos(pi),
                  radius * sin(pi),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(pi / 4),
                  radius * sin(pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(2 * pi / 4),
                  radius * sin(2 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(3 * pi / 4),
                  radius * sin(3 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(4 * pi / 4),
                  radius * sin(4 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(5 * pi / 4),
                  radius * sin(5 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(6 * pi / 4),
                  radius * sin(6 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(7 * pi / 4),
                  radius * sin(7 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
              Transform.translate(
                offset: Offset(
                  radius * cos(8 * pi / 4),
                  radius * sin(8 * pi / 4),
                ),
                child: Dot(radius: radius2, color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({Key? key, required this.radius, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
