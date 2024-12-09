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
  List<Sources>? sources;
  bool isInSearch;
  bool isInSearchResult;
  Errors? errors;
  int? index;
  List<Articles>? articles;
  int pageNumber;

  HomeState(
      {this.homeStatus,
      this.sources,
      this.pageNumber = 1,
      this.isInSearchResult = false,
      this.isInSearch = false,
      this.articles,
      this.index,
      this.errors});

  HomeState copyWith(
      {HomeStatus? homeStatus,
      int? index,
      bool? isInSearchResult,
      int? pageNumber,
      bool? isInSearch,
      List<Articles>? articles,
      List<Sources>? sources,
      Errors? errors}) {
    return HomeState(
        isInSearchResult: isInSearchResult ?? this.isInSearchResult,
        pageNumber: pageNumber ?? this.pageNumber,
        articles: articles ?? this.articles,
        index: index ?? this.index,
        isInSearch: isInSearch ?? this.isInSearch,
        homeStatus: homeStatus ?? this.homeStatus,
        sources: sources ?? this.sources,
        errors: errors ?? this.errors);
  }
}

final class HomeInitial extends HomeState {
  HomeInitial() : super(homeStatus: HomeStatus.initial, index: 0);
}
