import 'package:news/data/dataSourcesContract/NewsDataSource.dart';
import 'package:news/data/models/newsResponse.dart';
import 'package:news/data/shard/network/remote/api_manager.dart';

class NewsDataSourceImpl extends NewsDataSource {
  ApiManager apiManager;

  NewsDataSourceImpl(this.apiManager);

  @override
  Future<List<Articles>?> getNews(String sourceId, { required bool inSearch,
    required String? searchTitle,
    required int pageNumber,
    required String language})async {
    var response = await apiManager.getNews(source: sourceId,
        inSearch: inSearch,
        searchTitle: searchTitle,
        pageNumber: pageNumber,
        language: language);
    return response.articles;
  }

}