import 'package:final_project/ui/screens/tabs/browse/browse_screen.dart';
import 'package:final_project/ui/screens/tabs/home/home_tab.dart';
import 'package:final_project/ui/screens/tabs/search/search_screen.dart';
import 'package:final_project/ui/screens/tabs/watchlist/watch_list_screen.dart';
import 'package:final_project/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "Home-Screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    const SearchScreen(),
    const BrowseScreen(),
    const WatchListScreen()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: tabs[currentIndex],
      bottomNavigationBar:buildBottomNavBar(),
    );
  }

  Widget buildBottomNavBar()
  {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor:  AppColors.navBarDarkGrey),
      child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          selectedItemColor: AppColors.yellow,
          showUnselectedLabels: true,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 8),
          unselectedLabelStyle: const TextStyle(fontSize: 8),
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Browse"),
            BottomNavigationBarItem(icon: Icon(Icons.video_library_sharp), label: "WatchList"),
          ]),
    );
  }
}