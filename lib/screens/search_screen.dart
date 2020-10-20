import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/blocs/search_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/helpers/add_post.dart';
import 'package:epicture/main.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/cards/list_post_card.dart';
import 'package:epicture/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  int _selectedSort = 0;
  int _selectedWindow = 0;
  final _bloc = SearchBloc();
  final _interactionsBloc = InteractionsBloc();
  final _accessToken = sharedPreferences.get('access_token');
  final _sorts = ['time', 'viral', 'top'];
  final _windows = ['all', 'day', 'week', 'month', 'year'];

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  _fetchSearch() {
    _bloc.fetchSearch(
      _query,
      sort: _sorts[_selectedSort],
      window: _windows[_selectedWindow],
    );
  }

  _buildInputChipsRow(bool isSort, List<String> possibilities) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: possibilities.map((possibility) {
        final index = possibilities.indexOf(possibility);
        final currentIndex = isSort ? _selectedSort : _selectedWindow;

        return InputChip(
          selected: index == currentIndex,
          label: Text(possibilities[index]),
          selectedColor: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              if (isSort)
                _selectedSort = index;
              else
                _selectedWindow = index;
            });
            _fetchSearch();
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      floatingActionButton: _accessToken != null
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add an Image'),
              onPressed: () => addPost(context),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                SearchBar(
                  onChanged: (query) => setState(() {
                    _query = query;
                  }),
                  onSubmitted: _fetchSearch,
                ),
                _buildInputChipsRow(true, _sorts),
                _selectedSort == 0
                    ? _buildInputChipsRow(false, _windows)
                    : Container(),
              ],
            ),
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
                              onFavoriteTap:
                                  _interactionsBloc.addAlbumToFavorites,
                              onVoteTap: _interactionsBloc.voteForAlbum,
                            ),
                          );
                        },
                      ),
                    );
                  case Status.ERROR:
                    return Expanded(
                      child: Center(child: Text('Error while loading posts')),
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
