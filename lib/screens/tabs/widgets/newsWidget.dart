import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/newsResponse.dart';
import 'package:news/shard/style/colors.dart';

class ArticleWidget extends StatelessWidget {
  Articles? article;

  ArticleWidget(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),  
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: green),
            borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child:CachedNetworkImage(
                    imageUrl: article?.urlToImage ?? "", height: 200,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
    );
  }
}
