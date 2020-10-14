import 'package:epicture/blocs/search_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/navigation/action_button.dart';
import 'package:epicture/widgets/navigation/navigation_bar.dart';
import 'package:epicture/widgets/cards/list_post_card.dart';
import 'package:epicture/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _bloc = SearchBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ActionButton(),
      bottomNavigationBar: NavigationBar(pageNumber: 1),
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SearchBar(onSubmitted: _bloc.fetchSearch),
          ),
          StreamBuilder(
            stream: _bloc.searchStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  case Status.COMPLETED:
                    final List<Post> posts = snapshot.data.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: ListPostCard(
                              post: posts[index],
                              onFavoriteTap: null,
                            ),
                          );
                        },
                      ),
                    );
                }
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
