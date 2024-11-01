import '../models/newsResponse.dart';

abstract class NewsDataSource{
  Future<List<Articles>?> getNews(String sourceId, { required bool inSearch,
  required String? searchTitle,
    required int pageNumber,
  required String language});
}