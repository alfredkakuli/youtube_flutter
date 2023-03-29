import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget alertContainer(message, containerColor, textColor) => Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(color: containerColor, borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      child: Text(message.toString(), style: GoogleFonts.abel(color: textColor, fontSize: 16.0, decoration: TextDecoration.none)),
    );


    Widget smallSpacer() {
  return const SizedBox(
    height: 10.0,
  );
}

Widget smallHorinzontalSpacer() {
  return const SizedBox(
    width: 10.0,
  );
}

Widget largeSpacer() {
  return const SizedBox(
    height: 50.0,
  );
}
