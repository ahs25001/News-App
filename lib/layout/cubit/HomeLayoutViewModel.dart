import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/shard/network/remote/api_manager.dart';

import '../../models/categoryModel.dart';

class HomeLayoutViewModel extends Cubit<GetSourcesState> {
  HomeLayoutViewModel() : super(Loading());
  CategoryModel ?categoryModel;
  bool inSearch = false;
  TextEditingController searchController = TextEditingController();
  void getSources(String categoryId) async {
    emit(Loading());
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response.status == "error") {
        emit(Error(response.message ?? ""));
      } else {
        emit(Success(response.sources));
      }
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
