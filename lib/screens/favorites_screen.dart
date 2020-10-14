import 'package:epicture/blocs/favorites_bloc.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/cards/grid_post_card.dart';
import 'package:epicture/widgets/navigation/action_button.dart';
import 'package:epicture/widgets/navigation/navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _bloc = FavoritesBloc();

  @override
  dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
      body: StreamBuilder(
        stream: _bloc.favoritesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                final List<Post> posts = snapshot.data.data;
                if (posts.length == 0)
                  return Center(child: Text('You don\'t have any favorites'));
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: GridPostCard(
                        post: posts[index],
                        onFavoriteTap: null,
                      ),
                    );
                  },
                );
              case Status.ERROR:
                return Center(child: Text('Error while loading posts'));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
