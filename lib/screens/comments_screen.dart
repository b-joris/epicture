import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/main.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  /// [routeName] is the name used to navigate to this widget
  static const routeName = '/comments';

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _interactionsBloc = InteractionsBloc();
  final _commentController = TextEditingController();
  final _accessToken = sharedPreferences.get('access_token');

  _showDialog(String postID, Comment comment) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Write your reply'),
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
                  .addComment(postID, _commentController.text,
                      parentID: comment.id)
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
    /// An [Comment] must be pass as argument in order to display all the informations
    final Comment comment = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      floatingActionButton: _accessToken != null
          ? FloatingActionButton.extended(
              onPressed: () => _showDialog(comment.postID, comment),
              icon: Icon(Icons.edit),
              label: Text('Add a reply'),
              foregroundColor: Colors.white,
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comment.responses
                    .map((response) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: defaultPadding / 2),
                          child: CommentItem(comment: response),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
