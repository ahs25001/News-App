import 'package:news/data/dataSourcesContract/NewsDataSource.dart';
import 'package:news/data/models/newsResponse.dart';
import 'package:news/repoContract/NewsRepo.dart';

class NewsRepoImpl extends NewsRepo {
  NewsDataSource newsDataSource;

  NewsRepoImpl(this.newsDataSource);

  @override
  Future<List<Articles>?> getNews(String sourceId,
      {required bool inSearch,
        required pageNumber,
      required String? searchTitle,
      required String language}) {
    return newsDataSource.getNews(sourceId,
        pageNumber: pageNumber,
        inSearch: inSearch, searchTitle: searchTitle, language: language);
  }
}
