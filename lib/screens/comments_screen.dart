import 'package:epicture/constants.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  static const routeName = '/comments';

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    final Comment comment = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: comment.responses
                .map((response) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: defaultPadding / 2),
                      child: CommentItem(comment: response),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
