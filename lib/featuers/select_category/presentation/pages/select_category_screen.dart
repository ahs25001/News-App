import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_images.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../widgets/category_item.dart';


class SelectCategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(backgroundImage)),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.settings),
          title: Text(appName),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectMassage,
                style: selectMassageStyle,
              ),
              SizedBox(height: 29.h,),
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10.w,
                        childAspectRatio: 148.h/171.w,
                        mainAxisSpacing: 10.h,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => CategoryItem(
                        categories[index], index),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
