import 'package:flutter/material.dart';

import 'colors.dart';

class MyTheme{
  static ThemeData myTheme=ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(fontSize: 22),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: green,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(18),
              bottomLeft: Radius.circular(18))),
    )
  );
}