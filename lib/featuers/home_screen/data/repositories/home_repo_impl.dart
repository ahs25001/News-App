import 'package:dartz/dartz.dart';

import 'package:news_app/core/errors/errors.dart';
import 'package:news_app/featuers/home_screen/data/data_sources/home_ds.dart';
import 'package:news_app/featuers/home_screen/data/models/ArticlesModel.dart';

import 'package:news_app/featuers/home_screen/data/models/SourceModel.dart';

import '../../domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeDs homeDs;

  HomeRepoImpl(this.homeDs);

  @override
  Future<Either<Errors, SourceModel>> getSources(
          String categoryId, String language) =>
      homeDs.getSources(categoryId, language);

  @override
  Future<Either<Errors, ArticlesModel>> getArticles(String sourceId) =>
      homeDs.getArticles(sourceId);
}
