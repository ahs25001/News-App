import 'package:flutter/material.dart';
import 'package:news/screens/categories/categoryScreen.dart';
import 'package:news/screens/settings/settingsScreen.dart';
import 'package:news/screens/tabs/tabScreen.dart';
import 'package:news/shard/network/remote/api_manager.dart';
import 'package:news/shard/style/colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routName = "Home";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String? categoryTitle;
  bool inSearch = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        toCategoryScreen();
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.menu,
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Category",
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Settings(toCategoryScreen),
                        ));
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Settings",
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
        title: (!inSearch)
            ? (Text(
                (categoryTitle == null)
                    ? "News App".toUpperCase()
                    : categoryTitle!.toUpperCase(),
                style: const TextStyle(fontSize: 22)))
            : TextFormField(
                autofocus: true,
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: green,
                      ),
                      onPressed: () {
                        inSearch = false;
                        searchController.clear();
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
        centerTitle: true,
        backgroundColor: green,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(18))),
        actions: [
          (!inSearch && categoryTitle != null)
              ? IconButton(
                  onPressed: () {
                    inSearch = true;
                    setState(() {});
                  },
                  icon: const Icon(Icons.search))
              : const SizedBox()
        ],
      ),
      body: (categoryTitle == null)
          ? CategoryScreen(onCategorySelected)
          : RefreshIndicator(
              onRefresh: () {
                setState(() {});
                return Future.delayed(const Duration(seconds: 2));
              },
              child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: AlertDialog(
                          content: const Text(
                            "No InterNet",
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
                    }
                    var sources = snapshot.data?.sources ?? [];
                    return TabScreen(
                      sources: sources,
                      inSearch: inSearch,
                      titleOfSearch: searchController.text,
                    );
                  },
                  future: ApiManager.getSources(categoryTitle!)),
            ),
    );
  }

  onCategorySelected(String? selectedCategory) {
    categoryTitle = selectedCategory;
    setState(() {});
  }

  toCategoryScreen() {
    categoryTitle = null;
    inSearch=false;
    Navigator.pop(context);
    setState(() {});
  }
}
