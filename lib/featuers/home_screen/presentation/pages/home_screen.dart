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
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_images.dart';
import '../widgets/article_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late ScrollController scrollController;
  HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0 &&
            homeCubit.state.homeStatus != HomeStatus.getArticlesLoading) {
          await homeCubit.getArticles(
              homeCubit.state.sources?[homeCubit.state.index ?? 0].id ?? "");
        }
      }
    });
    super.initState();
  }

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
          create: (context) => homeCubit..getSources(args.id, "en"),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                return (state.homeStatus == HomeStatus.error)?Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(error),
                    Text("Time out Error",style: selectMassageStyle,)
                  ],
                )):((state.sources == null || state.sources!.isEmpty) &&
                        state.homeStatus == HomeStatus.getSourcesLoaded)
                    ? Center(child: Lottie.asset(notFound))
                    : (state.homeStatus == HomeStatus.getSourcesLoading)
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
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary),
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
                                      length: state.sources?.length ?? 0,
                                      child: TabBar(
                                          splashFactory: NoSplash.splashFactory,
                                          onTap: (value) {
                                            HomeCubit.get(context)
                                                .changeSource(value);
                                          },
                                          dividerColor: Colors.transparent,
                                          indicatorColor: Colors.transparent,
                                          isScrollable: true,
                                          tabs: (state.sources ?? [])
                                              .map((e) => SourceItem(
                                                    sourceId: e.id ?? "",
                                                    sourceName: e.name!,
                                                    isSelect: state.index ==
                                                        (state.sources ?? [])
                                                            .indexOf(e),
                                                  ))
                                              .toList())),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  (state.homeStatus ==
                                              HomeStatus.getArticlesLoading &&
                                          (state.articles == null ||
                                              state.articles!.isEmpty))
                                      ? const ArticleLoading()
                                      : ((state.articles == null ||
                                                  state.articles!.isEmpty) &&
                                              state.homeStatus ==
                                                  HomeStatus.getArticlesLoaded)
                                          ? Center(
                                              child: Lottie.asset(notFound))
                                          : Expanded(
                                              child: RefreshIndicator(
                                                onRefresh: () async {
                                                  HomeCubit.get(context)
                                                      .getArticles(
                                                          state
                                                                  .sources?[
                                                                      state.index ??
                                                                          0]
                                                                  .id ??
                                                              "",
                                                          refresh: true);
                                                },
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                triggerMode:
                                                    RefreshIndicatorTriggerMode
                                                        .anywhere,
                                                child: ListView.builder(
                                                  controller: scrollController,
                                                  itemCount: state.homeStatus ==
                                                          HomeStatus
                                                              .getArticlesLoading
                                                      ? (state.articles
                                                                  ?.length ??
                                                              0) +
                                                          1
                                                      : (state.articles
                                                              ?.length ??
                                                          0),
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index ==
                                                        (state.articles
                                                                ?.length ??
                                                            0)) {
                                                      return Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w,
                                                                  vertical:
                                                                      10.h),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.w,
                                                                  vertical:
                                                                      15.h),
                                                          decoration:
                                                              BoxDecoration(
                                                                  // color: Colors.white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(25
                                                                              .r),
                                                                  border: Border.all(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 360.w,
                                                                height: 232.h,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.vertical(
                                                                            top: Radius.circular(25
                                                                                .r)),
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                height: 15.h,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.r)),
                                                                width: 200.w,
                                                                height: 20.h,
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.r)),
                                                                width: 700.w,
                                                                height: 20.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return ArticleItem(
                                                        state.articles?[index]);
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
