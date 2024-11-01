import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/data/dataSourcesContract/NewsDataSource.dart';
import 'package:news/data/dataSourcesImpl/NewsDataSourceImpl.dart';
import 'package:news/data/repoImp/NewsRepoImpl.dart';
import 'package:news/repoContract/NewsRepo.dart';
import 'package:news/screens/tabs/widgets/articaleWidget.dart';
import 'package:news/screens/tabs/widgets/tabItem.dart';
import '../../data/models/SourceResponse.dart';
import '../../data/models/newsResponse.dart';
import '../../data/shard/network/remote/api_manager.dart';
import '../../data/shard/style/colors.dart';

class NewsScreen extends StatefulWidget {
  List<Sources> sources;
  bool inSearch;
  String? titleOfSearch;

  late NewsRepo newsRepo;
  late NewsDataSource newsDataSource;
  late ApiManager apiManager;

  NewsScreen(
      {super.key,
      required this.sources,
      required this.inSearch,
      required this.titleOfSearch}) {
    apiManager = ApiManager();
    newsDataSource = NewsDataSourceImpl(apiManager);
    newsRepo = NewsRepoImpl(newsDataSource);
  }

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int ind = 0;
  int pageNumber = 1;
  bool inNextPage = false;
  List<Articles> data = [];
  late ScrollController listController;

  @override
  void initState() {
    listController = ScrollController();
    listController.addListener(() {
      if (listController.position.atEdge) {
        if (listController.position.pixels != 0) {
          setState(() {
            pageNumber++;
            inNextPage = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Column(
        children: [
          DefaultTabController(
              length: widget.sources.length,
              child: TabBar(
                onTap: (value) {
                  ind = value;
                  data = [];
                  pageNumber = 1;
                  inNextPage = false;
                  listController.jumpTo(0);
                  setState(() {});
                },
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                isScrollable: true,
                tabs: widget.sources
                    .map((e) => TabItem(
                          nameOfSource: e.name!,
                          isSelected: ind == widget.sources.indexOf(e),
                        ))
                    .toList(),
              )),
          FutureBuilder(
            future: widget.newsRepo.getNews(widget.sources[ind].id ?? "",
                inSearch: widget.inSearch,
                pageNumber: pageNumber,
                searchTitle: widget.titleOfSearch,
                language: "en"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  data.isEmpty) {
                return Center(child: CircularProgressIndicator(color: green));
              }
              if (snapshot.hasError) {
                return const Text("Error");
              }
              if (data.isEmpty || inNextPage) {
                data.addAll(snapshot.data ?? []);
                print(pageNumber);
                print(data.length);
                inNextPage = false;
              }
              return Expanded(
                child: ListView.builder(
                  controller: listController,
                  itemBuilder: (context, index) {
                    if(index==data.length){
                      return Center(child: CircularProgressIndicator(color: green));
                    }
                    return FadeInDown(child: ArticleWidget(data[index]));
                  },
                  itemCount: data.length +
                      ((snapshot.connectionState == ConnectionState.waiting &&
                              data.isNotEmpty)
                          ? 1
                          : 0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
