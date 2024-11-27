import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/featuers/artical_web_view/presentation/pages/artical_web_view.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../home_screen/data/models/ArticlesModel.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Articles;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                backgroundImage,
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
              tag: "${args.source?.id}${args.source?.name}",
              child: Material(
                color: Colors.transparent,
                textStyle: appBarTitleStyle,
                child: Text(args.source?.name ?? ""),
              )),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Hero(
              tag: "${args.url}${args.title}${args.author}",
              child: FancyShimmerImage(
                imageUrl: '${args.urlToImage}',
                width: double.infinity,
                height: 232.h,
                errorWidget: Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Hero(
                        tag:
                            "${args.url}${args.title}${args.author}${args.author}",
                        child: Material(
                          textStyle:articleDateStyle ,
                            color: Colors.transparent,
                            child: Text(
                              args.author ?? "",
                              style: articleDateStyle,
                            ))),
                  ),
                  SizedBox(
                    height: 15.h,),
                  Text(
                    args.title ?? "",
                    style: articleTitleStyle,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        args.publishedAt ?? "",
                        style: articleDateStyle,
                      ))
                ],
              ),
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r)),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    Text(
                      args.description ?? "",
                      style: articleDescriptionStyle,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleWebView(args.url ?? ""),
                            ));
                      },
                      child: Text(
                        "view in browser",
                        style: viewInBrowserStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
