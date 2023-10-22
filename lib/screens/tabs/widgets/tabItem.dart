import 'package:flutter/material.dart';
import 'package:news/shard/style/colors.dart';

class TabItem extends StatelessWidget {
  String nameOfSource;
  bool isSelected;

  TabItem({super.key, required this.nameOfSource, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: green,width: 2),
                color: isSelected ? green : Colors.transparent),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Text(
              nameOfSource,
              style: TextStyle(color: isSelected ? Colors.white : green),
            )));
  }
}
