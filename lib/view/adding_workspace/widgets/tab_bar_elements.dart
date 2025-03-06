
import 'package:flutter/material.dart';
class TabBarElements extends StatelessWidget {
  const TabBarElements({
    super.key,
    required this.tabController,
    required this.selectedTab,
    required this.index, required this.title,
  });

  final TabController tabController;
  final int selectedTab;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => tabController.animateTo(index),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selectedTab == index
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title, style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
