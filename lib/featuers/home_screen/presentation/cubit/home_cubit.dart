import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/errors/errors.dart';
import 'package:news_app/featuers/home_screen/data/data_sources/home_ds_impl.dart';
import 'package:news_app/featuers/home_screen/data/models/ArticlesModel.dart';
import 'package:news_app/featuers/home_screen/data/models/SourceModel.dart';
import 'package:news_app/featuers/home_screen/domain/repositories/home_repo.dart';

import '../../data/repositories/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  TextEditingController searchController = TextEditingController();

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<bool> checkOnInternet() async {
    bool isConnected = await InternetConnection().hasInternetAccess;
    return isConnected;
  }

  void goTOSearch() {
    emit(state.copyWith(isInSearch: true));
    print("in search result ${state.isInSearchResult}");
  }

  void cancelSearch() {
    searchController.clear();
    emit(state.copyWith(isInSearch: false, isInSearchResult: false));
  }

  Future<void> getSources(String categoryId, String language) async {
    emit(state.copyWith(homeStatus: HomeStatus.getSourcesLoading));
    print("in get sources ==================================");
    bool isConnected = await checkOnInternet();
    if (!isConnected) {
      emit(state.copyWith(homeStatus: HomeStatus.noInternet));
    } else {
      HomeRepo homeRepo = HomeRepoImpl(HomeDsImpl());
      final failureOrSources = await homeRepo.getSources(categoryId, language);
      failureOrSources.fold(
          (failure) => emit(
              state.copyWith(errors: failure, homeStatus: HomeStatus.error)),
          (sources) async {
        emit(state.copyWith(
            homeStatus: HomeStatus.getSourcesLoaded,
            sources: sources.sources,
            index: 0));
        if(sources.sources?.isNotEmpty ?? false){
          await getArticles(sources.sources?[0].id ?? "",language);
        }
      });
    }
  }

  void changeSource(int index,String language) async {
    emit(state.copyWith(index: index, articles: []));
    await getArticles(state.sources?[index].id ?? "",language);
  }

  Future<void> getArticles(String sourceId,String language, {bool refresh = false}) async {
    emit(state.copyWith(
      pageNumber: refresh?1:null,
        homeStatus: HomeStatus.getArticlesLoading,
        articles: refresh ? [] : state.articles));

    HomeRepo homeRepo = HomeRepoImpl(HomeDsImpl());
    final failureOrArticles = await homeRepo.getArticles(sourceId,language,
        isSearch: state.isInSearch,
        query: searchController.text,
        pageNumber: state.pageNumber);
    failureOrArticles.fold(
        (failure) =>
            emit(state.copyWith(errors: failure, homeStatus: HomeStatus.error)),
        (articles) {
      List<Articles> newArticles = state.articles ?? [];
      newArticles.addAll(articles.articles ?? []);
      int newPageNumber = state.pageNumber + 1;
      emit(state.copyWith(
          homeStatus: HomeStatus.getArticlesLoaded,
          articles: newArticles,
          pageNumber: newPageNumber));
    });
  }

  Future<void> getSearchResultArticles(String sourceId,String language) async {
    emit(state
        .copyWith(homeStatus: HomeStatus.getArticlesLoading, articles: []));

    HomeRepo homeRepo = HomeRepoImpl(HomeDsImpl());
    final failureOrArticles = await homeRepo.getArticles(sourceId,language,
        isSearch: state.isInSearch,
        query: searchController.text,
        pageNumber: state.pageNumber);
    failureOrArticles.fold(
        (failure) =>
            emit(state.copyWith(errors: failure, homeStatus: HomeStatus.error)),
        (articles) {
      List<Articles> newArticles = state.articles ?? [];
      newArticles.addAll(articles.articles ?? []);
      int newPageNumber = state.pageNumber + 1;
      emit(state.copyWith(
          homeStatus: HomeStatus.getArticlesLoaded,
          articles: newArticles,
          isInSearchResult: true,
          pageNumber: newPageNumber));
    });
  }
}
