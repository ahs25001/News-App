import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/BodyViewModel.dart';
import 'package:news/layout/cubit/SourcestViewModel.dart';
import 'package:news/screens/categories/categoryScreen.dart';
import 'package:news/screens/settings/settingsScreen.dart';
import 'package:news/screens/tabs/newsScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/shard/style/colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routName = "Home";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>with SingleTickerProviderStateMixin {
  SourcesViewModel homeLayoutViewModel = SourcesViewModel();
  BodyViewModel bodyViewModel = BodyViewModel();
  late AnimationController animationController;
  late Animation<double>animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation= Tween<double>(end: 100000,begin: 0).animate(animationController);
    // animationController.forward();
    super.initState();
  }
  dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"))),
      child: BlocBuilder<BodyViewModel, BodyState>(
        bloc: bodyViewModel,
        builder: (BuildContext context, BodyState state) {
          switch (state) {
            case CategoryState():
              return Scaffold(
                  drawer: Drawer(
                    backgroundColor: Colors.white,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 80),
                            color: green,
                            child: const Text(
                              "News App",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      HomeLayout.routName,
                                      (route) => false,
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.menu,
                                        color: green,
                                        size: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.category,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: green,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Settings(
                                            bodyViewModel.toCategoryScreen);
                                      },
                                    ));
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.settings,
                                        size: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.settings,
                                        style: TextStyle(fontSize: 22),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    title: (!bodyViewModel.inSearch)
                        ? (Text(
                            (bodyViewModel.categoryModel == null)
                                ? "News App".toUpperCase()
                                : bodyViewModel.categoryModel!.title
                                    .toUpperCase(),
                          ))
                        : TextFormField(
                            autofocus: true,
                            controller: homeLayoutViewModel.searchController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 3),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: green,
                                  ),
                                  onPressed: () {
                                    bodyViewModel.inSearch = false;
                                    homeLayoutViewModel.searchController
                                        .clear();
                                    setState(() {});
                                  },
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: green)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: green)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: green)),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: green,
                                    )),
                                hintText: "Search Article",
                                hintStyle: const TextStyle(color: Colors.grey)),
                          ),
                    actions: [
                      (!bodyViewModel.inSearch &&
                              bodyViewModel.categoryModel != null)
                          ? IconButton(
                              onPressed: () {
                                bodyViewModel.inSearch = true;
                                setState(() {});
                              },
                              icon: const Icon(Icons.search))
                          : const SizedBox()
                    ],
                  ),
                  body: CategoryScreen(bodyViewModel.onCategorySelected));
            case NewsState():
              homeLayoutViewModel
                  .getSources(bodyViewModel.categoryModel?.id ?? "");
              return Scaffold(
                  drawer: Drawer(
                    backgroundColor: Colors.white,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 80),
                            color: green,
                            child: const Text(
                              "News App",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      HomeLayout.routName,
                                      (route) => false,
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.menu,
                                        color: green,
                                        size: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.category,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: green,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Settings(
                                            bodyViewModel.toCategoryScreen);
                                      },
                                    ));
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.settings,
                                        size: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.settings,
                                        style: TextStyle(fontSize: 22),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    title: (!bodyViewModel.inSearch)
                        ? (Text(
                            (bodyViewModel.categoryModel == null)
                                ? "News App".toUpperCase()
                                : bodyViewModel.categoryModel!.title
                                    .toUpperCase(),
                          ))
                        : ElasticInRight(
                          child: TextFormField(
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (value) =>
                                  homeLayoutViewModel.getSources(
                                      bodyViewModel.categoryModel?.id ?? ""),
                              autofocus: true,
                              controller: homeLayoutViewModel.searchController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 3),
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: green,
                                    ),
                                    onPressed: () {
                                      bodyViewModel.inSearch = false;
                                      homeLayoutViewModel.searchController
                                          .clear();
                                      setState(() {});
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: green)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: green)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        color: green,
                                      )),
                                  hintText: "Search Article",
                                  hintStyle: const TextStyle(color: Colors.grey)),
                            ),
                        ),
                    actions: [
                      (!bodyViewModel.inSearch &&
                              bodyViewModel.categoryModel != null)
                          ? IconButton(
                              onPressed: () {
                                bodyViewModel.inSearch = true;
                                setState(() {});
                              },
                              icon: const Icon(Icons.search))
                          : const SizedBox()
                    ],
                  ),
                  body: RefreshIndicator(
                      color: green,
                      onRefresh: () {
                        homeLayoutViewModel
                            .getSources(bodyViewModel.categoryModel?.id ?? "");
                        return Future.delayed(const Duration(seconds: 2));
                      },
                      child: BlocBuilder<SourcesViewModel, GetSourcesState>(
                        bloc: homeLayoutViewModel,
                        builder: (context, state) {
                          switch (state) {
                            case Loading():
                              return Center(
                                  child: CircularProgressIndicator(
                                color: green,
                              ));
                            case Error():
                              return Center(
                                child: AlertDialog(
                                  content: Text(
                                    state.errorMassage,
                                  ),
                                  title: const Text("Error"),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: green),
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Refresh"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.refresh)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            case Success():
                              return NewsScreen(
                                sources: state.sources ?? [],
                                inSearch: bodyViewModel.inSearch,
                                titleOfSearch:
                                    homeLayoutViewModel.searchController.text,
                              );
                          }
                        },
                      )));
          }
        },
      ),
    );
  }
}
// RefreshIndicator(
//         onRefresh: () {
//           setState(() {});
//           return Future.delayed(const Duration(seconds: 2));
//         },
//         child: BlocBuilder<SourcesViewModel, GetSourcesState>(
//           bloc: homeLayoutViewModel,
//           builder: (context, state) {
//             switch (state) {
//               case Loading():
//                 return Center(
//                     child: CircularProgressIndicator(
//                   color: green,
//                 ));
//               case Error():
//                 return Center(
//                   child: AlertDialog(
//                     content: Text(
//                       state.errorMassage,
//                     ),
//                     title: const Text("Error"),
//                     actions: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: green),
//                         onPressed: () {
//                           setState(() {});
//                         },
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text("Refresh"),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Icon(Icons.refresh)
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               case Success():
//                 return TabScreen(
//                   sources: state.sources ?? [],
//                   inSearch: bodyViewModel.inSearch,
//                   titleOfSearch:
//                       homeLayoutViewModel.searchController.text,
//                 );
//             }
//           },
//         )),
