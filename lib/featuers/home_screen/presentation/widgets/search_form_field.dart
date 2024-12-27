import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_styles.dart';

import '../../../../config/themes/themes.dart';
import '../../../settings_screen/presentation/cubit/settings_cubit.dart';
import '../cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SearchFormField extends StatelessWidget {
  BuildContext context;

  SearchFormField(this.context);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: HomeCubit.get(this.context).searchController,
      cursorColor: Theme.of(context).colorScheme.primary,
      cursorOpacityAnimates: true,
      autofocus: true,
      onFieldSubmitted: (value) {
        HomeCubit.get(this.context).getSearchResultArticles(
            HomeCubit.get(this.context)
                .state.sources?[0]
                .id ??
                "",SettingsCubit.get(context).state.language);
      },
      textInputAction: TextInputAction.search,
      style: articleTitleStyle,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.hintSearch,
          hintStyle: unselectedLabelStyle.copyWith(color:Theme.of(context).colorScheme.primary),
          prefixIcon: InkWell(
              onTap: () {
                HomeCubit.get(this.context).cancelSearch();
              },
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.primary,
                size: 25.sp,
              )),
          fillColor: Colors.white,
          filled: true,
          contentPadding:
          EdgeInsets.symmetric(vertical: 13.h),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(35.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(35.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(35.r),
          )),
    );
  }
}
