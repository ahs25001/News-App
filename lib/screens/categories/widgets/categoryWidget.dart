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
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: const Radius.circular(18),
              bottomRight: const Radius.circular(18))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          categoryModel.image,
          Text(categoryModel.title,style: const TextStyle(color: Colors.white,fontSize: 22),)
        ],
      ),
    );
  }
}
