import 'package:epicture/constants.dart';
import 'package:epicture/screens/account_screen.dart';
import 'package:epicture/screens/comments_screen.dart';
import 'package:epicture/screens/details_screen.dart';
import 'package:epicture/screens/favorites_screen.dart';
import 'package:epicture/screens/gallery_screen.dart';
import 'package:epicture/screens/login_screen.dart';
import 'package:epicture/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(Epicture());
}

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;

  final screens = [
    GalleryScreen(),
    SearchScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}

class Epicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
      initialRoute: '/navigation',
      routes: {
        '/navigation': (context) => NavigationBar(),
        '/gallery': (context) => GalleryScreen(),
        '/search': (context) => SearchScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/account': (context) => AccountScreen(),
        '/add': (context) => Container(),
        '/login': (context) => LoginScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
        CommentsScreen.routeName: (context) => CommentsScreen(),
      },
    );
  }
}
