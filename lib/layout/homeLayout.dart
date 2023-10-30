import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/HomeLayoutViewModel.dart';
import 'package:news/models/categoryModel.dart';
import 'package:news/screens/categories/categoryScreen.dart';
import 'package:news/screens/settings/settingsScreen.dart';
import 'package:news/screens/tabs/newsScreen.dart';
import 'package:news/shard/network/remote/api_manager.dart';
import 'package:news/shard/style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  static const String routName = "Home";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  HomeLayoutViewModel homeLayoutViewModel = HomeLayoutViewModel();

  @override
  Widget build(BuildContext context) {
    homeLayoutViewModel.getSources(homeLayoutViewModel.categoryModel?.id ?? "");
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"))),
      child: Scaffold(
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
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              return Settings(toCategoryScreen);
                            },
                          ));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
          title: (!homeLayoutViewModel.inSearch)
              ? (Text(
                  (homeLayoutViewModel.categoryModel == null)
                      ? "News App".toUpperCase()
                      : homeLayoutViewModel.categoryModel!.title.toUpperCase(),
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
                          homeLayoutViewModel.inSearch = false;
                          homeLayoutViewModel.searchController.clear();
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
            (!homeLayoutViewModel.inSearch &&
                    homeLayoutViewModel.categoryModel != null)
                ? IconButton(
                    onPressed: () {
                      homeLayoutViewModel.inSearch = true;
                      setState(() {});
                    },
                    icon: const Icon(Icons.search))
                : const SizedBox()
          ],
        ),
        body: (homeLayoutViewModel.categoryModel == null)
            ? CategoryScreen(onCategorySelected)
            : RefreshIndicator(
                onRefresh: () {
                  setState(() {});
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: BlocBuilder<HomeLayoutViewModel, GetSourcesState>(
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
                        return TabScreen(
                          sources: state.sources ?? [],
                          inSearch: homeLayoutViewModel.inSearch,
                          titleOfSearch:
                              homeLayoutViewModel.searchController.text,
                        );
                    }
                  },
                )),
      ),
    );
  }

  onCategorySelected(CategoryModel selectedCategory) {
    homeLayoutViewModel.categoryModel = selectedCategory;
    setState(() {});
  }

  toCategoryScreen() {
    homeLayoutViewModel.categoryModel = null;
    homeLayoutViewModel.inSearch = false;
    Navigator.pop(context);
    setState(() {});
  }
}
