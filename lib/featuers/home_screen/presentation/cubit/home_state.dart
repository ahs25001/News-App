part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  getSourcesLoading,
  getSourcesLoaded,
  getArticlesLoading,
  getArticlesLoaded,
  error
}

@immutable
class HomeState {
  HomeStatus? homeStatus;
  SourceModel? sourceModel;
  Errors? errors;
  int? index;
  ArticlesModel? articlesModel;

  HomeState(
      {this.homeStatus,
      this.sourceModel,
      this.articlesModel,
      this.index,
      this.errors});

  HomeState copyWith(
      {HomeStatus? homeStatus,
      int? index,
      ArticlesModel? articlesModel,
      SourceModel? sourceModel,
      Errors? errors}) {
    return HomeState(
        articlesModel: articlesModel ?? this.articlesModel,
        index: index ?? this.index,
        homeStatus: homeStatus ?? this.homeStatus,
        sourceModel: sourceModel ?? this.sourceModel,
        errors: errors ?? this.errors);
  }
}

final class HomeInitial extends HomeState {
  HomeInitial() : super(homeStatus: HomeStatus.initial, index: 0);
}
