import 'package:flutter/material.dart';
import 'package:news/models/categoryModel.dart';

class CategoryWidget extends StatelessWidget {
  CategoryModel categoryModel;

  CategoryWidget(this.categoryModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: categoryModel.color,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: categoryModel.image),
          Text(categoryModel.title,style: const TextStyle(color: Colors.white,fontSize: 22),)
        ],
      ),
    );
  }
}
