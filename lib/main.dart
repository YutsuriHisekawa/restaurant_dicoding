import 'package:flutter/material.dart';
import 'static/navigation_route.dart';
import 'screens/main/main_screen.dart';
import 'screens/detail/detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Track the dark mode state

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Toggle theme
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Switch theme based on state
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => MainScreen(
              onThemeSwitch:
                  _toggleTheme, // Pass the toggle function to MainScreen
              isDarkMode: _isDarkMode, // Pass current theme mode
            ),
        NavigationRoute.detailRoute.name: (context) => const DetailScreen(),
      },
    );
  }
}
