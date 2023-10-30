import 'package:bloc/bloc.dart';

class NewsScreenViewModel extends Cubit<NewsState>{
  NewsScreenViewModel(super.initialState);

}
abstract class NewsState{}
class Success extends NewsState{}
class Loading extends NewsState{}
class Error extends NewsState{}