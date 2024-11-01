import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/screens/article_screen.dart';

import '../../data/models/newsResponse.dart';

class DetailScreen extends StatelessWidget {
  static const String routName = "Detail screen";
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Articles;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.source!.name!.toUpperCase()),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: args.url!,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: args.urlToImage!,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                args.title!,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                args.publishedAt!.substring(0, 10),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            args.description!,
                            style: const TextStyle(fontSize: 17),
                          ),
                          SizedBox(height: 40,),
                          InkWell(
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => ArticleScreen(args.url!),));
                              },
                              child: Text(args.url!,style: const TextStyle(fontSize: 12,color: Colors.blue)))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
