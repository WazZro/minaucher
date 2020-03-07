import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  accentColorBrightness: Brightness.dark,
  backgroundColor: Colors.white,
  primaryColor: Colors.black,
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 32.0, color: Colors.black),
    body1: TextStyle(
        fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w300),
  ),
);

final dartTheme = ThemeData(
  brightness: Brightness.dark,
  accentColorBrightness: Brightness.light,
  backgroundColor: Colors.black,
  primaryColor: Colors.white,
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 32.0, color: Colors.white),
    body1: TextStyle(
        fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.w300),
  ),
);
