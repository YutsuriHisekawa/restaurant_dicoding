import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onThemeSwitch;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onThemeSwitch, required bool isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.wb_sunny
                : Icons.nightlight_round,
          ),
          onPressed: onThemeSwitch, 
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}
