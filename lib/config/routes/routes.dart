import 'package:flutter/cupertino.dart';
import 'package:news_app/featuers/article_screen/presentation/pages/article_screen.dart';
import 'package:news_app/featuers/settings_screen/presentation/pages/settings_screen.dart';

import '../../featuers/home_screen/presentation/pages/home_screen.dart';
import '../../featuers/select_category/presentation/pages/select_category_screen.dart';

class AppRoutes {
  static const String selectCategory = '/';
  static const String home = '/home';
  static const String details = '/details';
  static const String articles = '/articles';
  static const String settings = '/settings';
}

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.selectCategory:
        return CupertinoPageRoute(builder: (context) => SelectCategoryScreen());
      case AppRoutes.home:
        return CupertinoPageRoute(
            builder: (context) => HomeScreen(), settings: settings);
      case AppRoutes.articles:
        return CupertinoPageRoute(
            builder: (context) => ArticleScreen(), settings: settings);
      case AppRoutes.settings:
        return CupertinoPageRoute(builder: (context) => SettingsScreen(),);
      default:
        return CupertinoPageRoute(builder: (context) => SelectCategoryScreen());
    }
  }
}
