import 'package:Notim/feature/managment_category/model/category_note_model.dart';
import 'package:flutter/material.dart';

class CategoriesController extends ChangeNotifier {
  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'شخصی', color: Colors.blue),
    CategoryModel(id: '2', name: 'کار', color: Colors.green),
    CategoryModel(id: '3', name: 'دانشگاه', color: Colors.orange),
  ];
  List<CategoryModel> get categories => List.unmodifiable(_categories);

  void addCategory(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  void deleteCategory(String id) {
    _categories.removeWhere((cat) => cat.id == id);
    notifyListeners();
  }
}
