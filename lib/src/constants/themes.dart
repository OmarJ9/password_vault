import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

import 'package:sizer/sizer.dart';

class MyThemes {
  static var light = FlexThemeData.light(
    scheme: FlexScheme.aquaBlue,
  ).copyWith(
      textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          subtitle1: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          )));

  static var dark = FlexThemeData.dark(
    scheme: FlexScheme.aquaBlue,
    darkIsTrueBlack: true,
  ).copyWith(
      textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            color: MyColors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: GoogleFonts.poppins(
            color: MyColors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.normal,
          )));
}
