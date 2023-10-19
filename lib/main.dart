import 'package:flutter/material.dart';
import 'package:news/layout/homeLayout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {HomeLayout.routName: (context) => HomeLayout()},
      initialRoute: HomeLayout.routName,
      debugShowCheckedModeBanner: false,
    );
  }
}
