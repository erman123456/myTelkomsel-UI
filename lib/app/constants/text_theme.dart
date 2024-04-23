import 'package:flutter/material.dart';
import 'package:telkomsel/app/constants/font_family.dart';

class TelkomselTextStyle {
  TelkomselTextStyle._();

  static const batikSansFont = FontFamily.batikSans;

  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightBold = FontWeight.bold;

  static const Color colorDefault = Colors.black;

  static TextStyle normal = TextStyle(
    fontFamily: batikSansFont,
  );
  static TextStyle h5 = TextStyle(
    fontSize: 18,
    fontFamily: batikSansFont,
    fontWeight: weightBold,
    color: colorDefault,
  );
  static TextStyle h6 = TextStyle(
    fontSize: 14,
    fontFamily: batikSansFont,
    fontWeight: weightMedium,
    color: colorDefault,
  );
  static TextStyle h6Red = TextStyle(
    fontSize: 14,
    fontFamily: batikSansFont,
    fontWeight: weightMedium,
    color: Colors.red,
  );
  static TextStyle h6Bold = TextStyle(
    fontSize: 14,
    fontFamily: batikSansFont,
    fontWeight: weightBold,
    color: colorDefault,
  );
  static TextStyle h7 = TextStyle(
    fontSize: 12,
    fontFamily: batikSansFont,
    fontWeight: weightMedium,
    color: colorDefault,
  );
  static TextStyle h7Bold = TextStyle(
    fontSize: 12,
    fontFamily: batikSansFont,
    fontWeight: weightBold,
    color: colorDefault,
  );
  static TextStyle h7Red = TextStyle(
    fontSize: 12,
    fontFamily: batikSansFont,
    fontWeight: weightMedium,
    color: Colors.red,
  );
}
