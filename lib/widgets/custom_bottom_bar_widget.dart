import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChangedListener;

  const CustomBottomBar({
    Key? key,
    required this.selectedTab,
    required this.onTabChangedListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TabData> tabs = [
      const TabData(
        title: 'Home',
        iconData: Icons.home,
        tabColor: Colors.deepOrange,
        tabGradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
      ),
      const TabData(
        title: 'Favorite',
        iconData: Icons.favorite,
        tabColor: Colors.deepOrange,
        tabGradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
      ),
      const TabData(
        title: 'Search',
        iconData: Icons.search,
        tabColor: Colors.deepOrange,
        tabGradient: LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
      ),
    ];

    return CubertoBottomBar(
      inactiveIconColor: Colors.deepOrange,
      tabStyle: CubertoTabStyle.styleNormal,
      selectedTab: selectedTab,
      tabs: tabs
          .map(
            (value) => TabData(
              key: Key(value.title),
              iconData: value.iconData,
              title: value.title,
              tabColor: value.tabColor,
              tabGradient: value.tabGradient,
            ),
          )
          .toList(),
      onTabChangedListener: (position, title, color) {
        onTabChangedListener(position);
      },
    );
  }
}
