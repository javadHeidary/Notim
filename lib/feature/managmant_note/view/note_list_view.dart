import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/widget/custom_appbar_widget.dart';
import 'package:Notim/core/widget/custom_empty_widget.dart';
import 'package:Notim/core/widget/custom_note_widget.dart';
import 'package:Notim/core/widget/custom_snackbar_widget.dart';
import 'package:Notim/feature/managmant_note/controller/note_controller.dart';
import 'package:Notim/feature/managmant_note/model/note_model.dart';
import 'package:Notim/feature/managmant_note/view/add_note_view.dart';
import 'package:Notim/feature/managmant_note/view/edit_note_view.dart';
import 'package:Notim/feature/managment_category/controller/categories_controller.dart';
import 'package:Notim/feature/managment_category/model/category_note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({super.key});

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  Future<void> _openAddNote() async {
    final result = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => const AddNoteView()));

    if (result == true && mounted) {
      showSnackBarWidget(context, 'یادداشت با موفقیت اضافه شد');
    }
  }

  Future<void> _openEditNote(NoteModel note) async {
    final result = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => EditNoteView(note: note)));

    if (result == true && mounted) {
      showSnackBarWidget(context, 'یادداشت به‌روزرسانی شد');
    }
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteController>().notes;
    final categories = context.watch<CategoriesController>().categories;

    CategoryModel fallbackCategory = CategoryModel(
      id: '0',
      name: 'بدون دسته',
      color: AppColors.grey,
    );

    CategoryModel resolveCategory(String id) {
      if (categories.isEmpty) return fallbackCategory;
      return categories.firstWhere(
        (category) => category.id == id,
        orElse: () => fallbackCategory,
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openAddNote,
            label: Icon(Icons.add, color: AppColors.black),
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.black,
          ),
          body: Column(
            children: [
              CustomAppbarWidget(title: 'یادداشت‌ها'),
              notes.isEmpty
                  ? Expanded(
                      child: Center(
                        child: const CustomEmptyWidget(
                          title: 'یاداشتی نداری !',
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: notes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          final category = resolveCategory(note.categoryId);
                          final viewModel = context.read<NoteController>();

                          return CustomNoteWidget(
                            title: note.title,
                            content: note.content,
                            categoryColor: category.color,
                            isCompleted: note.status == NoteStatus.completed,
                            onTap: () => viewModel.toggleNoteStatus(note.id),
                            onStatusChanged: (_) =>
                                viewModel.toggleNoteStatus(note.id),
                            onEdit: () => _openEditNote(note),
                            onDelete: () {
                              viewModel.deleteNote(note);
                              showSnackBarWidget(
                                context,
                                'یادداشت با موفقیت حذف شد',
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
