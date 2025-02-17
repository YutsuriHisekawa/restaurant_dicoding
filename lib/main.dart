import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local_database_service.dart';
import 'package:restaurant_app/screens/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screens/provider/detail/review_provider.dart';
import 'package:restaurant_app/screens/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/screens/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/screens/provider/theme_provider.dart';
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
        Provider<LocalDatabaseService>(create: (_) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            Provider.of<ApiServices>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            Provider.of<LocalDatabaseService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            Provider.of<ApiServices>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProvider(
            Provider.of<ApiServices>(context, listen: false),
            'restaurantId',
          ),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnimatedTheme(
          duration: const Duration(milliseconds: 300),
          data: themeProvider.isDarkMode
              ? TemaData.darkTheme
              : TemaData.lightTheme,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: TemaData.lightTheme,
            darkTheme: TemaData.darkTheme,
            initialRoute: NavigationRoute.mainRoute.name,
            routes: {
              NavigationRoute.mainRoute.name: (context) => MainScreen(
                    onThemeSwitch: themeProvider.toggleTheme,
                    isDarkMode: themeProvider.isDarkMode,
                  ),
              NavigationRoute.detailRoute.name: (context) =>
                  const DetailScreen(),
              '/favorite': (context) => const FavoriteScreen(),
            },
          ),
        );
      },
    );
  }
}
