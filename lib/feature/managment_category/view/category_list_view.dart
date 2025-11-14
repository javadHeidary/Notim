import 'package:Notim/core/widget/custom_appbar_widget.dart';
import 'package:Notim/core/widget/custom_category_card.dart';
import 'package:Notim/core/widget/custom_empty_widget.dart';
import 'package:Notim/feature/managmant_note/controller/note_controller.dart';
import 'package:Notim/feature/managment_category/controller/categories_controller.dart';
import 'package:Notim/feature/managment_category/view/category_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListview extends StatelessWidget {
  const CategoryListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              CustomAppbarWidget(title: 'دسته‌بندی‌ها'),
              Expanded(
                child: Consumer2<CategoriesController, NoteController>(
                  builder:
                      (context, categoriesViewModel, notesViewModel, child) {
                        final categories = categoriesViewModel.categories;

                        if (categories.isEmpty) {
                          return const CustomEmptyWidget(title: 'دسته‌بندی');
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final notesCount = notesViewModel
                                .getNotesByCategory(category.id)
                                .length;

                            void openCategory() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      CategoryItemView(category: category),
                                ),
                              );
                            }

                            return CustomCategoryCard(
                              title: category.name,
                              subtitle: '$notesCount یادداشت',
                              categoryColor: category.color,
                              onTap: openCategory,
                              onArrowTap: openCategory,
                            );
                          },
                        );
                      },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
