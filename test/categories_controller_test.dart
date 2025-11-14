import 'package:Notim/feature/managment_category/controller/categories_controller.dart';
import 'package:Notim/feature/managment_category/model/category_note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoriesController', () {
    late CategoriesController controller;

    setUp(() {
      controller = CategoriesController();
    });

    test('initial state should have default categories', () {
      expect(controller.categories.length, 3);
      expect(controller.categories[0].id, '1');
      expect(controller.categories[0].name, 'شخصی');
      expect(controller.categories[0].color, Colors.blue);
      expect(controller.categories[1].id, '2');
      expect(controller.categories[1].name, 'کار');
      expect(controller.categories[1].color, Colors.green);
      expect(controller.categories[2].id, '3');
      expect(controller.categories[2].name, 'دانشگاه');
      expect(controller.categories[2].color, Colors.orange);
    });

    group('addCategory', () {
      test('should add a category to the list', () {
        final newCategory = CategoryModel(
          id: '4',
          name: 'جدید',
          color: Colors.purple,
        );

        controller.addCategory(newCategory);

        expect(controller.categories.length, 4);
        expect(controller.categories.last, newCategory);
        expect(controller.categories.last.id, '4');
        expect(controller.categories.last.name, 'جدید');
        expect(controller.categories.last.color, Colors.purple);
      });

      test('should add multiple categories', () {
        final category1 = CategoryModel(
          id: '4',
          name: 'ورزش',
          color: Colors.red,
        );

        final category2 = CategoryModel(
          id: '5',
          name: 'خرید',
          color: Colors.blue,
        );

        controller.addCategory(category1);
        controller.addCategory(category2);

        expect(controller.categories.length, 5);
        expect(controller.categories[3], category1);
        expect(controller.categories[4], category2);
      });

      test('should notify listeners when adding a category', () {
        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        final newCategory = CategoryModel(
          id: '4',
          name: 'تست',
          color: Colors.purple,
        );

        controller.addCategory(newCategory);

        expect(notified, isTrue);
      });
    });

    group('deleteCategory', () {
      test('should delete a category by id', () {
        expect(controller.categories.length, 3);

        controller.deleteCategory('1');

        expect(controller.categories.length, 2);
        expect(controller.categories.any((cat) => cat.id == '1'), isFalse);
        expect(controller.categories.any((cat) => cat.id == '2'), isTrue);
        expect(controller.categories.any((cat) => cat.id == '3'), isTrue);
      });

      test('should delete multiple categories', () {
        expect(controller.categories.length, 3);

        controller.deleteCategory('1');
        controller.deleteCategory('2');

        expect(controller.categories.length, 1);
        expect(controller.categories.first.id, '3');
      });

      test('should not delete anything if category does not exist', () {
        final initialLength = controller.categories.length;

        controller.deleteCategory('999');

        expect(controller.categories.length, initialLength);
      });

      test('should notify listeners when deleting a category', () {
        var notified = false;
        controller.addListener(() {
          notified = true;
        });

        controller.deleteCategory('1');

        expect(notified, isTrue);
      });

      test('should delete the correct category when multiple exist', () {
        final newCategory1 = CategoryModel(
          id: '4',
          name: 'ورزش',
          color: Colors.red,
        );

        final newCategory2 = CategoryModel(
          id: '5',
          name: 'خرید',
          color: Colors.blue,
        );

        controller.addCategory(newCategory1);
        controller.addCategory(newCategory2);

        controller.deleteCategory('4');

        expect(controller.categories.length, 4);
        expect(controller.categories.any((cat) => cat.id == '4'), isFalse);
        expect(controller.categories.any((cat) => cat.id == '5'), isTrue);
      });
    });

    group('categories getter', () {
      test('should return unmodifiable list', () {
        final newCategory = CategoryModel(
          id: '4',
          name: 'تست',
          color: Colors.purple,
        );

        expect(
          () => controller.categories.add(newCategory),
          throwsA(isA<UnsupportedError>()),
        );
      });

      test('should preserve initial categories', () {
        final initialCategories = controller.categories.toList();

        final newCategory = CategoryModel(
          id: '4',
          name: 'تست',
          color: Colors.purple,
        );

        controller.addCategory(newCategory);

        // Initial categories should still be present
        expect(controller.categories.length, 4);
        expect(controller.categories[0].id, initialCategories[0].id);
        expect(controller.categories[1].id, initialCategories[1].id);
        expect(controller.categories[2].id, initialCategories[2].id);
      });
    });

    group('integration tests', () {
      test('should add and delete categories correctly', () {
        final category1 = CategoryModel(
          id: '4',
          name: 'ورزش',
          color: Colors.red,
        );

        final category2 = CategoryModel(
          id: '5',
          name: 'خرید',
          color: Colors.blue,
        );

        controller.addCategory(category1);
        controller.addCategory(category2);

        expect(controller.categories.length, 5);

        controller.deleteCategory('4');
        expect(controller.categories.length, 4);
        expect(controller.categories.any((cat) => cat.id == '4'), isFalse);

        controller.deleteCategory('5');
        expect(controller.categories.length, 3);
        expect(controller.categories.any((cat) => cat.id == '5'), isFalse);

        // Original categories should still exist
        expect(controller.categories.length, 3);
        expect(controller.categories[0].id, '1');
        expect(controller.categories[1].id, '2');
        expect(controller.categories[2].id, '3');
      });
    });
  });
}
