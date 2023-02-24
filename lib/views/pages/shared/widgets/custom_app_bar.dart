import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  const CustomAppBar({
    Key? key,
    this.scrollOffset = 0.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 50.0, right: 20.0),
      height: 250.0,
      width: 250.0,
      // child: _logoImage(),
    );
  }

  Widget _logoImage() {
    double _logoDiameter = 200.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: _logoDiameter,
          width: _logoDiameter,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/logo.png'))),
        ),
      ],
    );
  }
}
