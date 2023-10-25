import 'package:flutter/material.dart';
import 'package:news/layout/homeLayout.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/screens/details/detailScreen.dart';
import 'package:news/screens/settings/settingsScreen.dart';
import 'package:news/shard/style/myTheme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return MyProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      theme: MyTheme.myTheme,
      locale: Locale(provider.local),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        HomeLayout.routName: (context) => const HomeLayout(),
        DetailScreen.routName:(context) => const DetailScreen()
      },
      initialRoute: HomeLayout.routName,
      debugShowCheckedModeBanner: false,
    );
  }
}
