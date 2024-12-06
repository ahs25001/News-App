import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_styles.dart';

import '../../../../config/themes/themes.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/home_cubit.dart';

class SearchFormField extends StatelessWidget {
  BuildContext context;

  SearchFormField(this.context);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: HomeCubit.get(this.context).searchController,
      cursorColor: lightTheme.colorScheme.primary,
      cursorOpacityAnimates: true,
      autofocus: true,
      onFieldSubmitted: (value) {
        HomeCubit.get(this.context).getArticles(
            HomeCubit.get(this.context)
                .state
                .sourceModel
                ?.sources?[0]
                .id ??
                "");
      },
      textInputAction: TextInputAction.search,
      style: articleTitleStyle,
      decoration: InputDecoration(
        hintText: "Search for articles",
          hintStyle: unselectedLabelStyle.copyWith(color:lightTheme.colorScheme.primary),
          prefixIcon: InkWell(
              onTap: () {
                HomeCubit.get(this.context).cancelSearch();
              },
              child: Icon(
                Icons.close,
                color: lightTheme.colorScheme.primary,
                size: 25.sp,
              )),
          fillColor: Colors.white,
          filled: true,
          contentPadding:
          EdgeInsets.symmetric(vertical: 13.h),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: lightTheme.colorScheme.primary),
            borderRadius: BorderRadius.circular(35.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightTheme.colorScheme.primary),
            borderRadius: BorderRadius.circular(35.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightTheme.colorScheme.primary),
            borderRadius: BorderRadius.circular(35.r),
          )),
    );
  }
}
