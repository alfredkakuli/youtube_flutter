import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';

inputDecoration(borderColor, textColor, iconColor, text, icon, action) => InputDecoration(
      contentPadding: const EdgeInsets.all(15.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderColor),
      ),
      labelStyle: GoogleFonts.abel(color: textColor),
      labelText: 'E-mail',
      suffixIcon: InkWell(
        onTap: () {
          action;
        },
        onHover: (value) {},
        child: Icon(icon, size: 20.0, color: iconColor),
      ),
    );
