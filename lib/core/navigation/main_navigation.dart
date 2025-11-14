import 'package:Notim/core/navigation/navigation_controller.dart';
import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:Notim/feature/managmant_note/view/note_list_view.dart';
import 'package:Notim/feature/managment_category/view/category_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [CategoryListview(), NoteListView()];

    final controller = Provider.of<NavigationController>(
      context,
      listen: false,
    );
    controller.setIndex(widget.initialIndex.clamp(0, _pages.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavigationController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(index: controller.currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyle.text(context: context),
        unselectedLabelStyle: AppTextStyle.text(context: context),
        currentIndex: controller.currentIndex,
        onTap: (index) => context.read<NavigationController>().setIndex(index),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.topic),
            activeIcon: Icon(Icons.topic),
            label: 'دسته‌بندی ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_outlined),
            activeIcon: Icon(Icons.sticky_note_2),
            label: 'یادداشت ها',
          ),
        ],
      ),
    );
  }
}
