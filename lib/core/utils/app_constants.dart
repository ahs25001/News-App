import '../../featuers/select_category/data/models/category_model.dart';
import 'app_colors.dart';
import 'app_images.dart';

String exoFont = "Exo";
String poppinsFont = "Poppins";
String interFont = "Inter";
List<CategoryModel> categories = [
  CategoryModel(
      image: sportsImage, name: "Sports", color: sportsColor, id: "sports"),
  CategoryModel(
      image: generalImage, name: "General", color: generalColor, id: "general"),
  CategoryModel(
      image: healthImage, name: "Health", color: healthColor, id: "health"),
  CategoryModel(
      image: businessImage,
      name: "Business",
      color: businessColor,
      id: "business"),
  CategoryModel(
      image: scienceImage, name: "Science", color: scienceColor, id: "science"),
  CategoryModel(
      image: environmentImage,
      name: "Environment",
      color: environmentColor,
      id: "entertainment"),
];
String apiKey = "1a86229d4d5e448787eaa74230eb8462";
String baseUrl = "https://newsapi.org/v2/";
