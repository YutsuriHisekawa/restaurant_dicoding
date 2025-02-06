import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/favorite/favorite_screen.dart';
import 'package:restaurant_app/screens/home/home_screen.dart';
import 'package:restaurant_app/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onThemeSwitch;
  final bool isDarkMode;

  const MainScreen({
    super.key,
    required this.onThemeSwitch,
    required this.isDarkMode,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
  ];

  String get _title {
    return _currentIndex == 0 ? 'Restaurant List' : 'Favorite List';
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _title,
        onThemeSwitch: widget.onThemeSwitch,
        isDarkMode: widget.isDarkMode,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
