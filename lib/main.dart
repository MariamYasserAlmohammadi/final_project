import 'package:final_project/ui/screens/tabs/details_screen/details_screen.dart';
import 'package:final_project/ui/screens/tabs/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/tabs/browse/browse_screen.dart';
import 'ui/screens/tabs/home/home_tab.dart';
import 'ui/screens/tabs/search/search_screen.dart';
import 'ui/screens/tabs/watchlist/watch_list_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          HomeTab.routeName: (_) => HomeTab(),
          BrowseScreen.routeName: (_) => const BrowseScreen(),
          SearchScreen.routeName: (_) => const SearchScreen(),
          WatchListScreen.routeName: (_) => const WatchListScreen(),
          DetailsScreen.routeName: (_) => DetailsScreen(),
        },
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}