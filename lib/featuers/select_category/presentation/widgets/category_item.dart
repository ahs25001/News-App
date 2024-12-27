import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/featuers/settings_screen/presentation/cubit/settings_cubit.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/category_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index;

  CategoryItem(this.categoryModel, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (SettingsCubit.get(context).state.isAutoTheme) {
          SettingsCubit.get(context)
              .changePrimaryColor(colors.indexOf(categoryModel.color));
        }
        Navigator.pushNamed(context, AppRoutes.home, arguments: categoryModel);
      },
      child: FadeInUp(
        delay: index == 0
            ? const Duration(milliseconds: 70)
            : Duration(milliseconds: index * 100),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: categoryModel.color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                  bottomRight: (SettingsCubit.get(context).state.language ==
                          "ar")
                      ? (index % 2 == 0 ? Radius.circular(25.r) : Radius.zero)
                      : index % 2 != 0
                          ? Radius.circular(25.r)
                          : Radius.zero,
                  bottomLeft: (SettingsCubit.get(context).state.language ==
                          "ar")
                      ? (index % 2 == 0 ? Radius.zero : Radius.circular(25.r))
                      : index % 2 != 0 &&
                              SettingsCubit.get(context).state.language == "en"
                          ? Radius.zero
                          : Radius.circular(25.r))),
          child: Column(
            children: [
              Hero(
                tag: "${categoryModel.id}${categoryModel.name}",
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(categoryModel.image,
                      width: 132.w, height: 116.h),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                AppLocalizations.of(context)!.categoryName(categoryModel.id),
                style: categoryTitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
