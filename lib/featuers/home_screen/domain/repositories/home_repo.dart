import 'package:dartz/dartz.dart';
import 'package:news_app/core/errors/errors.dart';

import '../../data/models/ArticlesModel.dart';
import '../../data/models/SourceModel.dart';

abstract class HomeRepo {
  Future<Either<Errors, SourceModel>> getSources(
      String categoryId, String language);
  Future<Either<Errors, ArticlesModel>> getArticles(String sourceId);
}
