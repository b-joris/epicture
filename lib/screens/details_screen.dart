import 'package:epicture/blocs/comments_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/comment_item.dart';
import 'package:epicture/widgets/fullscreen_image.dart';
import 'package:epicture/widgets/navigation/action_button.dart';
import 'package:epicture/widgets/navigation/navigation_bar.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = 'details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var _bloc = CommentsBloc('');

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    _bloc = CommentsBloc(post.id);

    return Scaffold(
      floatingActionButton: ActionButton(),
      bottomNavigationBar: NavigationBar(pageNumber: 0),
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: post.images.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(
                        imageUrl: post.images[index].link,
                        tag: 'image-${post.images[index].id}',
                      );
                    }))
                  },
                  child: Hero(
                    child: Image.network(post.images[index].link),
                    tag: 'image-${post.images[index].id}',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  post.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.arrow_drop_up),
                    Text(post.ups.toString()),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.arrow_drop_down),
                    Text(post.downs.toString()),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: _bloc.commentsStream,
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
                        print(snapshot.data);
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
      ),
    );
  }
}
