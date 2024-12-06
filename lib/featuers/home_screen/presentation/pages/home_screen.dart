import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/core/utils/app_json.dart';
import 'package:news_app/core/utils/app_styles.dart';
import 'package:news_app/featuers/home_screen/presentation/cubit/home_cubit.dart';
import 'package:news_app/featuers/home_screen/presentation/widgets/article_loading.dart';
import 'package:news_app/featuers/home_screen/presentation/widgets/search_form_field.dart';
import 'package:news_app/featuers/home_screen/presentation/widgets/source_item.dart';
import 'package:news_app/featuers/home_screen/presentation/widgets/sources_loading.dart';
import 'package:news_app/featuers/select_category/data/models/category_model.dart';
import 'package:news_app/featuers/settings_screen/presentation/cubit/settings_cubit.dart';

import '../../../../core/utils/app_images.dart';
import '../widgets/article_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return PopScope(
      onPopInvoked: (didPop) {
        if (SettingsCubit.get(context).state.isAutoTheme) {
          SettingsCubit.get(context).changePrimaryColor(0);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundImage), fit: BoxFit.cover),
        ),
        child: BlocProvider(
          create: (context) => HomeCubit()..getSources(args.id, "en"),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: BlocSelector<HomeCubit, HomeState, bool>(
                selector: (state) {
                  return state.isInSearch;
                },
                builder: (context, isInSearch) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeInQuart,
                    switchOutCurve: Curves.easeInQuart,
                    transitionBuilder: (child, animation) => ScaleTransition(
                      alignment: Alignment.centerRight,
                      scale: animation,
                      // sizeFactor: animation,
                      child: child,
                    ),
                    child: (isInSearch)
                        ? SearchFormField(context)
                        : Hero(
                            tag: "${args.id}${args.name}",
                            child: Material(
                                textStyle: appBarTitleStyle,
                                color: Colors.transparent,
                                child: Text(
                                  args.name,
                                  textAlign: TextAlign.center,
                                ))),
                  );
                },
              ),
              actions: [
                BlocSelector<HomeCubit, HomeState, bool>(
                  selector: (state) {
                    return state.isInSearch;
                  },
                  builder: (context, isInSearch) {
                    return isInSearch
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              HomeCubit.get(context).goTOSearch();
                            },
                            child: Icon(
                              Icons.search,
                              size: 40.sp,
                              color: Colors.white,
                            ),
                          );
                  },
                ),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
            body: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return (state.homeStatus == HomeStatus.getSourcesLoading)
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          const SourcesLoading(),
                          const ArticleLoading()
                        ],
                      )
                    : (state.homeStatus == HomeStatus.noInternet)
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(noInternet),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).colorScheme.primary),
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .getSources(args.id, "en");
                                    },
                                    child: Text(
                                      "Tray again",
                                      style: appBarTitleStyle,
                                    ))
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              DefaultTabController(
                                  length:
                                      state.sourceModel?.sources?.length ?? 0,
                                  child: TabBar(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: (value) {
                                        HomeCubit.get(context)
                                            .changeSource(value);
                                      },
                                      dividerColor: Colors.transparent,
                                      indicatorColor: Colors.transparent,
                                      isScrollable: true,
                                      tabs: (state.sourceModel?.sources ?? [])
                                          .map((e) => SourceItem(
                                                sourceId: e.id ?? "",
                                                sourceName: e.name!,
                                                isSelect: state.index ==
                                                    (state.sourceModel
                                                                ?.sources ??
                                                            [])
                                                        .indexOf(e),
                                              ))
                                          .toList())),
                              SizedBox(
                                height: 10.h,
                              ),
                              (state.homeStatus ==
                                      HomeStatus.getArticlesLoading)
                                  ? const ArticleLoading()
                                  : Expanded(
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          HomeCubit.get(context).getArticles(
                                              state
                                                      .sourceModel
                                                      ?.sources?[
                                                          state.index ?? 0]
                                                      .id ??
                                                  "");
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        triggerMode: RefreshIndicatorTriggerMode
                                            .anywhere,
                                        child: ListView.builder(
                                          itemCount: state.articlesModel
                                                  ?.articles?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return ArticleItem(state
                                                .articlesModel
                                                ?.articles?[index]);
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
