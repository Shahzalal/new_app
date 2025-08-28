import 'package:news_app/models/news_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  categories.add(CategoryModel(categoryName: "Business"));
  categories.add(CategoryModel(categoryName: "Entertainment"));
  categories.add(CategoryModel(categoryName: "General"));
  categories.add(CategoryModel(categoryName: "Health"));
  categories.add(CategoryModel(categoryName: "Science"));
  categories.add(CategoryModel(categoryName: "Sports"));
  categories.add(CategoryModel(categoryName: "Technology"));
  return categories;
}
