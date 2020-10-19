import 'package:epicture/main.dart';
import 'package:epicture/screens/login_screen.dart';
import 'package:epicture/widgets/account/account_posts.dart';
import 'package:epicture/widgets/account/favorites_posts.dart';
import 'package:flutter/material.dart';

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
    Tab(icon: Icon(Icons.person)),
    Tab(icon: Icon(Icons.settings)),
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
                Navigator.pushReplacementNamed(context, '/gallery');
              })
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: accountTabs,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AccountPosts(),
          FavoritesPosts(),
          Center(
            child: Text(
              selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ),
          Center(
            child: Text(
              selectedIndex.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}
