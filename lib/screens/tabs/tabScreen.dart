import 'package:flutter/material.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/screens/tabs/widgets/articaleWidget.dart';
import 'package:news/screens/tabs/widgets/tabItem.dart';
import 'package:news/shard/network/remote/api_manager.dart';
import 'package:provider/provider.dart';

import '../../models/newsResponse.dart';

class TabScreen extends StatefulWidget {
  List<Sources> sources;
  bool inSearch;
  String? titleOfSearch;

  TabScreen(
      {super.key, required this.sources,
      required this.inSearch,
      required this.titleOfSearch});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Column(
        children: [
          DefaultTabController(
              length: widget.sources.length,
              child: TabBar(
                onTap: (value) {
                  ind = value;
                  setState(() {});
                },
                indicatorColor: Colors.transparent,
                isScrollable: true,
                tabs: widget.sources
                    .map((e) => TabItem(
                          nameOfSource: e.name!,
                          isSelected: ind == widget.sources.indexOf(e),
                        ))
                    .toList(),
              )),
          FutureBuilder(
            future: ApiManager.getNews(
                source: widget.sources[ind].id ?? "",
                inSearch: widget.inSearch,
                searchTitle: widget.titleOfSearch,
                language: provider.local),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Text("Error");
              }
              List<Articles> data = snapshot.data?.articles ?? [];
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ArticleWidget(data[index]);
                  },
                  itemCount: data.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
