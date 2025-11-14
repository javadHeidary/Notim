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

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();

    final categories = Provider.of<CategoriesController>(
      context,
      listen: false,
    ).categories;
    if (categories.isNotEmpty) {
      _selectedCategoryId = categories.first.id;
    }
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

    final viewModel = Provider.of<NoteController>(context, listen: false);
    final newNote = NoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      categoryId: _selectedCategoryId!,
      status: NoteStatus.draft,
      createdAt: DateTime.now(),
    );

    viewModel.addNote(newNote);
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
                const CustomAppbarWidget(
                  title: 'ایجاد یادداشت',
                  isBackButton: true,
                ),
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
                      : null,
                  label: 'دسته‌بندی',
                  hint: 'یک دسته‌بندی انتخاب کنید',
                  items: categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category.id,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(category.name),
                                SizedBox(width: AppTheme.size(context, 8)),
                              ],
                            ),
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
                const Spacer(),
                CustomElevatedButton(
                  title: 'ذخیره ',
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
