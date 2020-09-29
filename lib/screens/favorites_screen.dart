import 'package:epicture/widgets/navigation/action_button.dart';
import 'package:epicture/widgets/navigation/navigation_bar.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ActionButton(),
      bottomNavigationBar: NavigationBar(pageNumber: 2),
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Container(),
    );
  }
}
