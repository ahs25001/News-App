import 'package:news/data/dataSourcesContract/SourcesDataSource.dart';
import 'package:news/data/models/SourceResponse.dart';
import 'package:news/repoContract/sourcesRepo.dart';

class SourcesRepoImpl extends SourcesRepo{
  SourcesDataSource sourcesDataSource;

  SourcesRepoImpl(this.sourcesDataSource);

  @override
  Future<List<Sources>?> getSources(String categoryId) {
   return sourcesDataSource.getSource(categoryId);
  }

}