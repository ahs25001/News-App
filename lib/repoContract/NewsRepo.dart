import 'package:news/data/models/newsResponse.dart';

abstract class NewsRepo {
  Future<List<Articles>?> getNews(String sourceId,
      {required bool inSearch,
        required int pageNumber,
      required String? searchTitle,
      required String language});
}
