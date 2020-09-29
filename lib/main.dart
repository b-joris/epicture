import 'package:epicture/constants.dart';
import 'package:epicture/screens/account_screen.dart';
import 'package:epicture/screens/gallery_screen.dart';
import 'package:epicture/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(Epicture());
}

class Epicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        scaffoldBackgroundColor: Colors.blueAccent,
      ),
      initialRoute: '/gallery',
      routes: {
        '/gallery': (context) => GalleryScreen(),
        '/search': (context) => SearchScreen(),
        '/account': (context) => AccountScreen(),
      },
    );
  }
}
