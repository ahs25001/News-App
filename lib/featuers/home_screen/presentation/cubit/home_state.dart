part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  getSourcesLoading,
  getSourcesLoaded,
  getArticlesLoading,
  getArticlesLoaded,
  isConnected,
  noInternet,
  error
}

@immutable
class HomeState {
  HomeStatus? homeStatus;
  SourceModel? sourceModel;
  bool isInSearch;
  Errors? errors;
  int? index;
  ArticlesModel? articlesModel;

  HomeState(
      {this.homeStatus,
      this.sourceModel,
      this.isInSearch = false,
      this.articlesModel,
      this.index,
      this.errors});

  HomeState copyWith(
      {HomeStatus? homeStatus,
      int? index,
      bool? isInSearch,
      ArticlesModel? articlesModel,
      SourceModel? sourceModel,
      Errors? errors}) {
    return HomeState(
        articlesModel: articlesModel ?? this.articlesModel,
        index: index ?? this.index,
        isInSearch: isInSearch ?? this.isInSearch,
        homeStatus: homeStatus ?? this.homeStatus,
        sourceModel: sourceModel ?? this.sourceModel,
        errors: errors ?? this.errors);
  }
}

final class HomeInitial extends HomeState {
  HomeInitial() : super(homeStatus: HomeStatus.initial, index: 0);
}
