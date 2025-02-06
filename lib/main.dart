import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/tema_data.dart';
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
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: TemaData.lightTheme,
      darkTheme: TemaData.darkTheme,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => MainScreen(
              onThemeSwitch: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
        NavigationRoute.detailRoute.name: (context) => const DetailScreen(),
      },
    );
  }
}
