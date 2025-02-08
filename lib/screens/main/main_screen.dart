import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/screens/search/search_screen.dart';
import 'package:restaurant_app/screens/main/index_nav_provider.dart';
import 'package:restaurant_app/widgets/custom_app_bar_widget.dart';
import 'package:restaurant_app/widgets/custom_bottom_bar_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final VoidCallback onThemeSwitch;
  final bool isDarkMode;

  const MainScreen({
    super.key,
    required this.onThemeSwitch,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final int selectedIndex =
        context.watch<IndexNavProvider>().indexBottomNavBar;
    String appBarTitle;
    switch (selectedIndex) {
      case 0:
        appBarTitle = 'Restaurant List';
        break;
      case 1:
        appBarTitle = 'Favorite List';
        break;
      case 2:
        appBarTitle = 'Search Restaurant';
        break;
      default:
        appBarTitle = 'Restaurant App';
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: appBarTitle,
        onThemeSwitch: onThemeSwitch,
        isDarkMode: isDarkMode,
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          if (value.indexBottomNavBar == 1) {
            return const FavoriteScreen();
          } else if (value.indexBottomNavBar == 2) {
            return const SearchScreen();
          } else {
            return const HomeScreen();
          }
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedTab: selectedIndex,
        onTabChangedListener: (position) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = position;
        },
      ),
    );
  }
}
