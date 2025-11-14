import 'package:Notim/core/navigation/main_navigation.dart';
import 'package:Notim/core/navigation/navigation_controller.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:Notim/feature/managmant_note/controller/note_controller.dart';
import 'package:Notim/feature/managment_category/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Taskim());
}

class Taskim extends StatelessWidget {
  const Taskim({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationController()),
        ChangeNotifierProvider(create: (context) => CategoriesController()),
        ChangeNotifierProvider(create: (context) => NoteController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taskim',
        theme: AppTheme.lightTheme,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: const MainNavigation(),
        ),
      ),
    );
  }
}
