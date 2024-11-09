import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/routes/routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index;

  CategoryItem(this.categoryModel, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.home, arguments: categoryModel);
      },
      child: FadeInUp(
        delay: index==0?Duration(milliseconds:70):Duration(milliseconds: index*100),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: categoryModel.color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                  bottomRight:
                      index % 2 != 0 ? Radius.circular(25.r) : Radius.zero,
                  bottomLeft:
                      index % 2 != 0 ? Radius.zero : Radius.circular(25.r))),
          child: Column(
            children: [
              Image.asset(categoryModel.image, width: 132.w, height: 116.h),
              SizedBox(
                height: 25.h,
              ),
              Text(
                categoryModel.name,
                style: categoryTitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}