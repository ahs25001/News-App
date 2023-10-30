import 'package:flutter/material.dart';
import 'package:news/models/categoryModel.dart';
import 'package:news/screens/categories/widgets/categoryWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryScreen extends StatelessWidget {
  Function onCategorySelected;

  CategoryScreen(this.onCategorySelected, {super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = [
      CategoryModel(
          title: AppLocalizations.of(context)!.business,
          id: "Business",
          color: const Color(0XFFCF7E48),
          image: Image.asset("assets/images/bussines.png")),
      CategoryModel(
          id: "Sports",
          title: AppLocalizations.of(context)!.sport,
          color: const Color(0XFFC91C22),
          image: Image.asset("assets/images/ball.png")),
      CategoryModel(
          title: AppLocalizations.of(context)!.health,
          id: "Health",
          color: const Color(0XFFED1E79),
          image: Image.asset("assets/images/health.png")),
      CategoryModel(
          title: AppLocalizations.of(context)!.science,
          id: "Science",
          color: const Color(0XFFF2D352),
          image: Image.asset("assets/images/science.png")),
      CategoryModel(
          title: AppLocalizations.of(context)!.technology,
          id: "Technology",
          color: const Color(0XFF4882CF),
          image: Image.asset("assets/images/environment.png")),
      CategoryModel(
          title: AppLocalizations.of(context)!.general,
          id: "General",
          color: const Color(0XFF003E90),
          image: Image.asset("assets/images/Politics.png")),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                onCategorySelected(categories[index]);
              },
              child: CategoryWidget(categories[index]));
        },
      ),
    );
  }
}
