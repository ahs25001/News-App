import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String local="en";
  changeLocal(String local)
  {
    this.local=local;
    notifyListeners();
  }
}