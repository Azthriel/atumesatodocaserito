import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle display({
    double size = 52,
    Color color = AppColors.charcoal,
    FontStyle style = FontStyle.normal,
    FontWeight weight = FontWeight.w600,
  }) =>
      GoogleFonts.cormorantGaramond(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
        height: 1.05,
      );

  static TextStyle body({
    double size = 15,
    Color color = AppColors.warmGray,
    FontWeight weight = FontWeight.w300,
  }) =>
      GoogleFonts.nunito(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: 1.85,
      );

  static TextStyle label({Color color = AppColors.orange}) =>
      GoogleFonts.nunito(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 3.5,
        height: 1,
      );

  static TextStyle nav() => GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.warmGray,
        letterSpacing: 1.5,
      );
}
