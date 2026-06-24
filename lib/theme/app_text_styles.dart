import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle wordmark = GoogleFonts.playfairDisplay(
    fontSize: 44,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle screenTitle = GoogleFonts.playfairDisplay(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle appBarTitle = GoogleFonts.playfairDisplay(
    fontSize: 15,
    fontStyle: FontStyle.italic,
  );

  static final TextStyle cardTitle = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle listTitle = GoogleFonts.playfairDisplay(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle serifBody = GoogleFonts.playfairDisplay(
    fontSize: 15,
  );

  static final TextStyle serifItalicMuted = GoogleFonts.playfairDisplay(
    fontSize: 16,
    fontStyle: FontStyle.italic,
  );

  static final TextStyle buttonLabel = GoogleFonts.barlowCondensed(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
  );

  static final TextStyle chipLabel = GoogleFonts.barlowCondensed(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  static final TextStyle caption = GoogleFonts.barlowCondensed(
    fontSize: 14,
    letterSpacing: 0.3,
  );

  static final TextStyle kicker = GoogleFonts.barlowCondensed(
    fontSize: 11,
    letterSpacing: 2.0,
  );
}
