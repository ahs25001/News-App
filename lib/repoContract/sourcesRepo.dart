import 'package:news/data/models/SourceResponse.dart';

abstract class SourcesRepo {
  Future<List<Sources>?> getSources(String categoryId);
}
