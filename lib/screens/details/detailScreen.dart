import 'package:flutter/material.dart';

import '../../models/newsResponse.dart';

class DetailScreen extends StatelessWidget {
  static const String routName = "Detail screen";

  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Articles;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.source!.name!.toUpperCase() ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(args.urlToImage!)),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [Text(args.description!,style: const TextStyle(fontSize: 17),)],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
