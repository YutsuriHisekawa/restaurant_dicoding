import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromARGB(255, 22, 22, 22)
            : Colors.deepOrange,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        cursorColor: isDarkMode ? Colors.deepOrange : Colors.white,
        cursorWidth: 3.0,
        style: TextStyle(color: isDarkMode ? Colors.deepOrange : Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for a restaurant...',
          hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey[700] : Colors.grey[300]),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.deepOrange : Colors.white,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.restaurant_sharp,
              color: isDarkMode ? Colors.deepOrange : Colors.white,
            ),
            onPressed: () {},
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
