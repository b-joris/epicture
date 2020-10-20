import 'package:epicture/blocs/comments_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class AccountComments extends StatefulWidget {
  @override
  _AccountCommentsState createState() => _AccountCommentsState();
}

class _AccountCommentsState extends State<AccountComments> {
  final _commentsBloc = CommentsBloc();

  @override
  void initState() {
    super.initState();
    _commentsBloc.fetchUserComments();
  }

  @override
  void dispose() {
    _commentsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _commentsBloc.fetchUserComments(),
      child: StreamBuilder(
        stream: _commentsBloc.commentsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                List<Comment> comments = snapshot.data.data;
                if (comments.length == 0)
                  return Center(child: Text('You didn\'t post any comment'));
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: comments
                          .map((comment) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: defaultPadding / 2),
                                child: CommentItem(comment: comment),
                              ))
                          .toList(),
                    ),
                  ),
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
