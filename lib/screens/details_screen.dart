import 'package:epicture/blocs/comments_bloc.dart';
import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/main.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/cards/details_card.dart';
import 'package:epicture/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _interactionsBloc = InteractionsBloc();
  final _commentController = TextEditingController();
  final _accessToken = sharedPreferences.get('access_token');

  var _commentsBloc;

  @override
  void dispose() {
    _commentsBloc.dispose();
    super.dispose();
  }

  _showDialog(String postID) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Write your comment'),
        content: TextField(
          controller: _commentController,
        ),
        actions: [
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_commentController.text.isEmpty) return;
              _interactionsBloc
                  .addComment(postID, _commentController.text)
                  .then(
                (isSend) {
                  if (isSend) {
                    _commentController.text = '';
                    Navigator.pop(context);
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    _commentsBloc = CommentsBloc.fromPost(post.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      floatingActionButton: _accessToken != null
          ? FloatingActionButton.extended(
              onPressed: () => _showDialog(post.id),
              label: Text('Add a comment'),
              icon: Icon(Icons.edit),
              foregroundColor: Colors.white,
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            post: post,
            onFavoriteTap: _interactionsBloc.addAlbumToFavorites,
            onVoteTap: _interactionsBloc.voteForAlbum,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _commentsBloc.commentsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.COMPLETED:
                      final List<Comment> comments = snapshot.data.data;
                      return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: CommentItem(
                              comment: comments[index],
                            ),
                          );
                        },
                      );
                    case Status.ERROR:
                      return Center(
                          child: Text('Error while loading comments'));
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
