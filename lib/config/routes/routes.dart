import 'package:flutter/material.dart';
import 'package:news_app/featuers/article_screen/presentation/pages/article_screen.dart';

import '../../featuers/home_screen/presentation/pages/home_screen.dart';
import '../../featuers/select_category/presentation/pages/select_category_screen.dart';

class AppRoutes {
  static const String selectCategory = '/';
  static const String home = '/home';
  static const String details = '/details';
  static const String articles = '/articles';
}

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.selectCategory:
        return MaterialPageRoute(builder: (context) => SelectCategoryScreen());
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (context) => HomeScreen(), settings: settings);
      case AppRoutes.articles:
        return MaterialPageRoute(builder: (context) => ArticleScreen(),settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => SelectCategoryScreen());
    }
  }
}
