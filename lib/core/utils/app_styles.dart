import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_colors.dart';

import 'app_constants.dart';

TextStyle selectMassageStyle = TextStyle(
    color: secondaryColor, fontWeight: FontWeight.w700, fontSize: 22.sp);
TextStyle appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: exoFont,
    fontWeight: FontWeight.w400,
    fontSize: 22.sp);
TextStyle categoryTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: exoFont,
  fontWeight: FontWeight.w400,
  fontSize: 22.sp,
);
TextStyle selectedLabelStyle = TextStyle(
  color: Colors.white,
  fontFamily: exoFont,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
TextStyle unselectedLabelStyle = TextStyle(
  color: primaryColor,
  fontFamily: exoFont,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
TextStyle authorNameStyle = TextStyle(
  color: authorColor,
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
);
TextStyle descriptionStyle = TextStyle(
  color: descriptionColor,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
TextStyle articleTitleStyle = TextStyle(
  color: descriptionColor,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
);
TextStyle articleDescriptionStyle = TextStyle(
  color: descriptionColor,
  fontWeight: FontWeight.w300,
  fontSize: 14.sp,
);
TextStyle articleDateStyle = TextStyle(
  color: articleDateColor,
  fontWeight: FontWeight.w400,
  fontFamily: interFont,
  fontSize: 14.sp,
);
TextStyle viewInBrowserStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);
ButtonStyle tryAgainButtonStyle=ElevatedButton.styleFrom(backgroundColor: primaryColor);