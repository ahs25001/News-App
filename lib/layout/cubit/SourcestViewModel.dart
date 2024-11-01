import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/data/dataSourcesContract/SourcesDataSource.dart';
import 'package:news/data/dataSourcesImpl/dataSourceImpl.dart';
import 'package:news/data/repoImp/sourcesRepoImpl.dart';
import 'package:news/repoContract/sourcesRepo.dart';

import '../../data/models/SourceResponse.dart';
import '../../data/shard/network/remote/api_manager.dart';
import 'BodyViewModel.dart';

class SourcesViewModel extends Cubit<GetSourcesState> {
  late SourcesRepo sourcesRepo;
  late SourcesDataSource sourcesDataSource;
  late ApiManager apiManager;

  SourcesViewModel() : super(Loading()) {
    apiManager = ApiManager();
    sourcesDataSource = SourcesDataSourceImpl(apiManager);
    sourcesRepo = SourcesRepoImpl(sourcesDataSource);
  }

  TextEditingController searchController = TextEditingController();

  void getSources(String categoryId) async {
    emit(Loading());
    try {
      var response = await sourcesRepo.getSources(categoryId);

      emit(Success(response));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

sealed class GetSourcesState {}

class Success extends GetSourcesState {
  List<Sources>? sources;

  Success(this.sources);
}

class Loading extends GetSourcesState {}

class Error extends GetSourcesState {
  String errorMassage;

  Error(this.errorMassage);
}
