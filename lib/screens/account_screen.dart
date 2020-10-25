import 'package:epicture/helpers/add_post.dart';
import 'package:epicture/main.dart';
import 'package:epicture/screens/login_screen.dart';
import 'package:epicture/widgets/account/account_comments.dart';
import 'package:epicture/widgets/account/account_posts.dart';
import 'package:epicture/widgets/account/account_settings.dart';
import 'package:epicture/widgets/account/account_favorites.dart';
import 'package:flutter/material.dart';

/// Display the information about the logged user
///
/// It used [AccountPosts], [AccountFavorites], [AccountComments], [AccountSettings]
class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  final _accessToken = sharedPreferences.get('access_token');

  TabController tabController;
  int selectedIndex = 0;

  List<Widget> accountTabs = [
    Tab(icon: Icon(Icons.collections)),
    Tab(icon: Icon(Icons.favorite)),
    Tab(icon: Icon(Icons.message)),
    Tab(icon: Icon(Icons.person)),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: accountTabs.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedIndex = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_accessToken == null) return LoginScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                sharedPreferences.remove('access_token');
                Navigator.pushReplacementNamed(context, '/navigation');
              })
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: accountTabs,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add an Image'),
        foregroundColor: Colors.white,
        onPressed: () => addPost(context),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AccountPosts(),
          AccountFavorites(),
          AccountComments(),
          AccountSettings(),
        ],
      ),
    );
  }
}
