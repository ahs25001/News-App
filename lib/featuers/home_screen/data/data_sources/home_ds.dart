import 'package:dartz/dartz.dart';
import 'package:news_app/featuers/home_screen/data/models/ArticlesModel.dart';

import '../../../../core/errors/errors.dart';
import '../models/SourceModel.dart';

abstract class HomeDs {
  Future<Either<Errors, SourceModel>> getSources(
      String categoryId, String language);

  Future<Either<Errors, ArticlesModel>> getArticles(String sourceId,
      {required bool? isSearch, String? query,required int pageNumber});
}
