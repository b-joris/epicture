import 'package:epicture/constants.dart';
import 'package:epicture/providers/theme_provider.dart';
import 'package:epicture/screens/account_screen.dart';
import 'package:epicture/screens/add_screen.dart';
import 'package:epicture/screens/comments_screen.dart';
import 'package:epicture/screens/details_screen.dart';
import 'package:epicture/screens/gallery_screen.dart';
import 'package:epicture/screens/login_screen.dart';
import 'package:epicture/screens/search_screen.dart';
import 'package:epicture/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPreferences] used to save the access token and the theme of the user
SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(Epicture());
}

class Epicture extends StatefulWidget {
  @override
  _EpictureState createState() => _EpictureState();
}

class _EpictureState extends State<Epicture> {
  ThemePreferenceProvider _themePreference = ThemePreferenceProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    _themePreference.darkTheme =
        sharedPreferences.getBool(ThemePreferenceProvider.THEME_STATUS) ??
            false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _themePreference,
      child: Consumer<ThemePreferenceProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: primaryColor,
              accentColor: accentColor,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              primaryColor: darkPrimaryColor,
              accentColor: darkAccentColor,
              brightness: Brightness.dark,
            ),
            themeMode:
                _themePreference.darkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/navigation',
            routes: {
              '/navigation': (context) => NavigationBar(),
              '/gallery': (context) => GalleryScreen(),
              '/search': (context) => SearchScreen(),
              '/account': (context) => AccountScreen(),
              '/login': (context) => LoginScreen(),
              DetailsScreen.routeName: (context) => DetailsScreen(),
              CommentsScreen.routeName: (context) => CommentsScreen(),
              AddScreen.routeName: (context) => AddScreen(),
            },
          );
        },
      ),
    );
  }
}
