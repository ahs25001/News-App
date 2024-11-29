import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_colors.dart';

class ArticleLoading extends StatelessWidget {
  const ArticleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          // shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: primaryColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 360.w,
                    height: 232.h,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.r)),
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.r)),
                    width: 200.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.r)),
                    width: 700.w,
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
