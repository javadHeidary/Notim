import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:Notim/core/widget/custom_appbar_widget.dart';
import 'package:Notim/core/widget/custom_dropdown_widget.dart';
import 'package:Notim/core/widget/custom_elevated_button.dart';
import 'package:Notim/core/widget/custom_text_field_widget.dart';
import 'package:Notim/feature/managmant_note/controller/note_controller.dart';
import 'package:Notim/feature/managmant_note/model/note_model.dart';
import 'package:Notim/feature/managment_category/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNoteView extends StatefulWidget {
  final NoteModel note;
  const EditNoteView({super.key, required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late NoteStatus _selectedStatus;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedStatus = widget.note.status;
    _selectedCategoryId = widget.note.categoryId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false) ||
        _selectedCategoryId == null) {
      return;
    }

    final updatedNote = widget.note.copyWith(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      categoryId: _selectedCategoryId,
      status: _selectedStatus,
    );

    Provider.of<NoteController>(context, listen: false).updateNote(updatedNote);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoriesController>().categories;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.size(context, 14)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomAppbarWidget(title: 'ویرایش', isBackButton: true),
                CustomTextFieldWidget(
                  controller: _titleController,
                  label: 'عنوان',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'لطفاً عنوان را وارد کنید';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppTheme.size(context, 16)),
                CustomTextFieldWidget(
                  controller: _contentController,
                  label: 'متن',
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'لطفاً متن یادداشت را وارد کنید';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppTheme.size(context, 16)),
                CustomDropdownWidget<String>(
                  value:
                      categories.any(
                        (category) => category.id == _selectedCategoryId,
                      )
                      ? _selectedCategoryId
                      : (categories.isNotEmpty ? categories.first.id : null),
                  label: 'دسته‌بندی',
                  hint: 'یک دسته‌بندی انتخاب کنید',
                  items: categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category.id,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(category.name),
                          ),
                        ),
                      )
                      .toList(),
                  enabled: categories.isNotEmpty,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'یک دسته‌بندی انتخاب کنید';
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppTheme.size(context, 16)),
                CustomDropdownWidget<NoteStatus>(
                  value: _selectedStatus,
                  label: 'وضعیت',
                  items: NoteStatus.values
                      .map(
                        (status) => DropdownMenuItem<NoteStatus>(
                          value: status,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              status == NoteStatus.completed
                                  ? 'تکمیل شده'
                                  : 'پیش‌نویس',
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
                const Spacer(),
                CustomElevatedButton(
                  title: 'ذخیره تغییرات',
                  onPressed: categories.isEmpty ? () {} : _submit,
                ),
                SizedBox(height: AppTheme.size(context, 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
