import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/favorite_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/detail/review_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/screens/detail/detail_screen.dart';
import 'package:restaurant_app/screens/main/index_nav_provider.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/theme/tema_data.dart';
import 'package:restaurant_app/screens/main/main_screen.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiServices>(create: (_) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            Provider.of<ApiServices>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteListProvider()),
        ChangeNotifierProvider(
            create: (context) => RestaurantDetailProvider(
                Provider.of<ApiServices>(context, listen: false))),
        ChangeNotifierProvider(
            create: (context) => ReviewProvider(
                Provider.of<ApiServices>(context, listen: false),
                'restaurantId')),
      ],
      child: const MyApp(),
    ),
  );
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
        '/favorite': (context) => const FavoriteScreen(),
      },
    );
  }
}
