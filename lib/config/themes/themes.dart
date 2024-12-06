import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/app_styles.dart';

import '../../core/utils/app_constants.dart';

//Search Article
ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: greenPrimaryColor,
        onPrimary: greenPrimaryColor,
        secondary: secondaryColor,
        onSecondary: secondaryColor,
        error: redPrimaryColor,
        onError: redPrimaryColor,
        surface: Colors.white,
        onSurface: Colors.black),
    fontFamily: poppinsFont,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: greenPrimaryColor.withOpacity(.5),
        selectionHandleColor: greenPrimaryColor),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white, size: 25.sp),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r))),
      backgroundColor: greenPrimaryColor,
      centerTitle: true,
      titleTextStyle: appBarTitleStyle,
    ));
ThemeData secondLightTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: redPrimaryColor,
        onPrimary: greenPrimaryColor,
        secondary: secondaryColor,
        onSecondary: secondaryColor,
        error: redPrimaryColor,
        onError: redPrimaryColor,
        surface: Colors.white,
        onSurface: Colors.black),
    fontFamily: poppinsFont,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: redPrimaryColor.withOpacity(.5),
        selectionHandleColor: redPrimaryColor),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white, size: 25.sp),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r))),
      backgroundColor: redPrimaryColor,
      centerTitle: true,
      titleTextStyle: appBarTitleStyle,
    ));
ThemeData thirdLightTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: purplePrimaryColor,
        onPrimary: greenPrimaryColor,
        secondary: secondaryColor,
        onSecondary: secondaryColor,
        error: redPrimaryColor,
        onError: redPrimaryColor,
        surface: Colors.white,
        onSurface: Colors.black),
    fontFamily: poppinsFont,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: purplePrimaryColor.withOpacity(.5),
        selectionHandleColor: purplePrimaryColor),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white, size: 25.sp),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r))),
      backgroundColor: purplePrimaryColor,
      centerTitle: true,
      titleTextStyle: appBarTitleStyle,
    ));
