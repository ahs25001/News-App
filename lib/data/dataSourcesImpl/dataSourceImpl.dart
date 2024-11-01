import 'package:news/data/models/SourceResponse.dart';
import 'package:news/data/shard/network/remote/api_manager.dart';
import '../dataSourcesContract/SourcesDataSource.dart';

class SourcesDataSourceImpl extends SourcesDataSource{
  ApiManager apiManager;

  SourcesDataSourceImpl(this.apiManager);

  @override
  Future<List<Sources>?> getSource(String categoryId)async {
   SourceResponse response =await apiManager.getSources(categoryId);
   return response.sources;
  }

}