import '../models/SourceResponse.dart';

abstract class SourcesDataSource {
  Future<List<Sources>?> getSource(String categoryId);
}