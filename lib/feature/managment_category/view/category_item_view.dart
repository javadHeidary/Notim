import 'package:Notim/core/navigation/navigation_controller.dart';
import 'package:Notim/core/widget/custom_appbar_widget.dart';
import 'package:Notim/core/widget/custom_empty_widget.dart';
import 'package:Notim/core/widget/custom_note_widget.dart';
import 'package:Notim/core/widget/custom_snackbar_widget.dart';
import 'package:Notim/feature/managmant_note/controller/note_controller.dart';
import 'package:Notim/feature/managmant_note/model/note_model.dart';
import 'package:Notim/feature/managmant_note/view/edit_note_view.dart';
import 'package:Notim/feature/managment_category/model/category_note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItemView extends StatelessWidget {
  final CategoryModel category;

  const CategoryItemView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              CustomAppbarWidget(
                title: category.name,
                isBackButton: true,
                color: category.color,
              ),

              Expanded(
                child: Consumer<NoteController>(
                  builder: (context, managmentNoteViewModel, child) {
                    final notes = managmentNoteViewModel.getNotesByCategory(
                      category.id,
                    );

                    if (notes.isEmpty) {
                      return const CustomEmptyWidget(
                        title: '! هیچ یادداشتی وجود ندارد',
                      );
                    }

                    return ListView.separated(
                      itemCount: notes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      padding: const EdgeInsets.only(bottom: 16),
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        final isCompleted = note.status == NoteStatus.completed;

                        return CustomNoteWidget(
                          title: note.title,
                          content: note.content,
                          categoryColor: category.color,
                          isCompleted: isCompleted,
                          onTap: () =>
                              managmentNoteViewModel.toggleNoteStatus(note.id),
                          onStatusChanged: (_) =>
                              managmentNoteViewModel.toggleNoteStatus(note.id),
                          onEdit: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditNoteView(note: note),
                              ),
                            );
                            if (result == true && context.mounted) {
                              context.read<NavigationController>().setIndex(1);
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            }
                          },
                          onDelete: () {
                            managmentNoteViewModel.deleteNote(note);
                            showSnackBarWidget(
                              context,
                              'یادداشت با موفقیت حذف شد',
                            );
                          },
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
