import 'package:bloc/bloc.dart';

import '../../data/models/categoryModel.dart';

class BodyViewModel extends Cubit<BodyState> {
  BodyViewModel() : super(CategoryState());
  CategoryModel? categoryModel;
  bool inSearch = false;

  onCategorySelected(CategoryModel selectedCategory) {
    categoryModel = selectedCategory;
    emit(NewsState());
  }

  toCategoryScreen() {
    categoryModel = null;
    inSearch = false;
    emit(CategoryState());
  }
}

sealed class BodyState {}

class CategoryState extends BodyState {}

class NewsState extends BodyState {}
