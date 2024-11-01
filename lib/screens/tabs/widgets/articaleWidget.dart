import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/details/detailScreen.dart';

import '../../../data/models/newsResponse.dart';
import '../../../data/shard/style/colors.dart';

class ArticleWidget extends StatelessWidget {
  Articles? article;
  // int index;
  ArticleWidget(this.article,{super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DetailScreen.routName,
          arguments: article),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: green),
              borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            child: Column(
              children: [
                Hero(
                  tag: article?.url??"",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: article?.urlToImage ?? "",
                      height: 200,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: green,
                      )),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(article?.source!.name ?? ""),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  article?.title ?? "",
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(article?.publishedAt!.substring(0, 10) ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
