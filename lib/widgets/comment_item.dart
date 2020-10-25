import 'package:epicture/models/comment.dart';
import 'package:epicture/screens/comments_screen.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({
    Key key,
    @required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.author,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(comment.comment),
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            CommentsScreen.routeName,
            arguments: comment,
          ),
          child: Text(
            comment.responses.length > 0 ? 'View replies' : '',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
