import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/featuers/home_screen/presentation/cubit/home_cubit.dart';
import 'package:news_app/featuers/home_screen/presentation/widgets/source_item.dart';
import 'package:news_app/featuers/select_category/data/models/category_model.dart';

import '../../../../core/utils/app_images.dart';
import '../widgets/article_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(backgroundImage)),
      ),
      child: BlocProvider(
        create: (context) => HomeCubit()..getSources(args.id, "en"),
        child: Scaffold(
          appBar: AppBar(
            title: Text(args.name),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return (state.homeStatus == HomeStatus.getSourcesLoading)
                  ? Center(
                      child: CircularProgressIndicator(
                      color: primaryColor,
                    ))
                  : Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        DefaultTabController(
                            length: state.sourceModel?.sources?.length ?? 0,
                            child: TabBar(
                                splashFactory: NoSplash.splashFactory,
                                onTap: (value) {
                                  HomeCubit.get(context).changeSource(value);
                                },
                                dividerColor: Colors.transparent,
                                indicatorColor: Colors.transparent,
                                isScrollable: true,
                                tabs: (state.sourceModel?.sources ?? [])
                                    .map((e) => SourceItem(
                                  sourceId: e.id??"",
                                          sourceName: e.name!,
                                          isSelect: state.index ==
                                              (state.sourceModel?.sources ?? [])
                                                  .indexOf(e),
                                        ))
                                    .toList())),
                        SizedBox(
                          height: 10.h,
                        ),
                        (state.homeStatus == HomeStatus.getArticlesLoading)
                            ? CircularProgressIndicator(
                                color: primaryColor,
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      state.articlesModel?.articles?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    return ArticleItem(state.articlesModel
                                            ?.articles?[index]);
                                  },
                                ),
                              ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
