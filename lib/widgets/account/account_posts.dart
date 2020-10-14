import 'package:epicture/blocs/account_posts_bloc.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../favorite_card.dart';

class AccountPosts extends StatefulWidget {
  @override
  _AccountPostsState createState() => _AccountPostsState();
}

class _AccountPostsState extends State<AccountPosts> {
  final _bloc = AccountPostsBloc();

  @override
  dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => _bloc.fetchAccountPosts(),
        child: StreamBuilder(
          stream: _bloc.accountPostsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  final List<Post> posts = snapshot.data.data;
                  print(posts.length);
                  if (posts.length == 0) {
                    print('0 posts');
                    return Center(
                        child: Text('You don\'t have any post yet !'));
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: FavoriteCard(
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
        ));
  }
}
