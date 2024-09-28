import 'package:flutter/material.dart';
import 'package:movies/UI/HomeScreen/bottom_nav_widget.dart';
import 'package:movies/UI/MainNavTabs/HomeTab/home_tab.dart';

import '../MainNavTabs/BrowseTab/browse_tab.dart';
import '../MainNavTabs/SearchTab/search_tab.dart';
import '../MainNavTabs/WatchListTab/watch_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavWidget(
              size.height * 0.006,
              size.height * 0.003,
              "HOME",
              iconPath: "Assets/AppAssets/Icons/Home icon@2x.png",
              Theme.of(context).colorScheme.surface,
            ),
            BottomNavWidget(
                size.height * 0.006,
                size.height * 0.003,
                "SEARCH",
                iconPath: "Assets/AppAssets/Icons/searchIcon@2x.png",
                Theme.of(context).colorScheme.surface),
            BottomNavWidget(
                size.height * 0.006,
                size.height * 0.003,
                "BROWSE",
                iconPath: "Assets/AppAssets/Icons/Browse Icon@2x.png",
                Theme.of(context).colorScheme.surface),
            BottomNavWidget(
                size.height * 0.006,
                size.height * 0.003,
                "WATCHLIST",
                iconPath: "Assets/AppAssets/Icons/Watch List Icon@2x.png",
                Theme.of(context).colorScheme.surface),
          ],
        ));
  }
}

var tabs = [
  const HomeTab(),
  const SearchTab(),
  const BrowseTab(),
  const WatchListTab(),
];
