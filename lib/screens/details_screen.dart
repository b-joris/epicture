import 'package:epicture/blocs/comments_bloc.dart';
import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/cards/details_card.dart';
import 'package:epicture/widgets/comment_item.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = 'details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _interactionsBloc = InteractionsBloc();
  var _commentsBloc = CommentsBloc('');

  @override
  void dispose() {
    _commentsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    _commentsBloc = CommentsBloc(post.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
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
                            child: CommentItem(comment: comments[index]),
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
