import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/app_styles.dart';

import '../../core/utils/app_constants.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: poppinsFont,
  scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white, size: 25.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r),bottomRight:Radius.circular(40.r) )),
  backgroundColor: primaryColor,
  centerTitle: true,
  titleTextStyle: appBarTitleStyle,
));
