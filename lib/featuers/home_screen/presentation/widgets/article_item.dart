import 'package:animate_do/animate_do.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/featuers/home_screen/data/models/ArticlesModel.dart';

import '../../../../config/themes/themes.dart';
import '../../../../core/utils/app_styles.dart';

class ArticleItem extends StatelessWidget {
  Articles? articles;

  ArticleItem(this.articles);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.articles, arguments: articles);
      },
      child: FadeInDown(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(color: lightTheme.colorScheme.primary)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "${articles?.url}${articles?.title}${articles?.author}",
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.r)),
                  child: FancyShimmerImage(
                    imageUrl: '${articles?.urlToImage}',
                    width: 360.w,
                    height: 232.h,
                    errorWidget: Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Hero(
                tag:
                    "${articles?.url}${articles?.title}${articles?.author}${articles?.author}",
                child: Material(
                  color: Colors.transparent,
                  textStyle: authorNameStyle,
                  child: Text(
                    articles?.author ?? "",
                    style: authorNameStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                articles?.title ?? "",
                style: descriptionStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
