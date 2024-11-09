import 'package:dartz/dartz.dart';
import 'package:news_app/core/api/api_manager.dart';
import 'package:news_app/core/api/end_points.dart';
import 'package:news_app/featuers/home_screen/data/models/ArticlesModel.dart';
import 'package:news_app/featuers/home_screen/data/models/SourceModel.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/utils/app_constants.dart';
import 'home_ds.dart';

class HomeDsImpl implements HomeDs {
  @override
  Future<Either<Errors, SourceModel>> getSources(
      String categoryId, String language) async {
    try {
      ApiManager apiManager = ApiManager.instance;
      var response = await apiManager.getData(
          "$baseUrl$getSourcesEndPoint?apiKey=$apiKey&category=$categoryId&language=$language");
      return Right(SourceModel.fromJson(response));
    } catch (e) {
      return Left(RemoteError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, ArticlesModel>> getArticles(String sourceId) async{
    try {
      ApiManager apiManager = ApiManager.instance;
      print(sourceId);
      var response = await apiManager.getData(
          "$baseUrl$getArticlesEndPoint?apiKey=$apiKey&sources=$sourceId");
      return Right(ArticlesModel.fromJson(response));
    } catch (e) {
      return Left(RemoteError(e.toString()));
    }
  }
}
