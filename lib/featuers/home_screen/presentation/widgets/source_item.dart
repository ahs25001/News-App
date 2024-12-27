import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/themes/themes.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/app_styles.dart';

class SourceItem extends StatelessWidget {
  String sourceName;
  bool isSelect;
  String sourceId;

  SourceItem(
      {required this.sourceName,
      required this.isSelect,
      required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "$sourceId$sourceName",
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              color: isSelect
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(25.r)),
          child: Text(
            sourceName,
            style: isSelect
                ? selectedLabelStyle
                : unselectedLabelStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
