import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final Function onFavoriteTap;

  const PostCard({
    @required this.post,
    @required this.onFavoriteTap,
    Key key,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  VideoPlayerController controller;

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildPreview() {
    if (widget.post.images[0].link.contains('mp4')) {
      return Center(child: CircularProgressIndicator());
      // print(widget.post.title);
      // controller = VideoPlayerController.network(widget.post.images[0].link);
      // controller.setLooping(true);
      // controller.initialize().then((_) => setState(() {}));
      // controller.play();
      // return VideoPlayer(controller);
    }
    return AspectRatio(
      aspectRatio: 1.5,
      child: Image.network(
        widget.post.images[0].link,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgess) {
          if (loadingProgess == null) return child;
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (Navigator.pushNamed(context, DetailsScreen.routeName,
          arguments: widget.post)),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.post.title ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding),
                    child: GestureDetector(
                      onTap: () => widget.onFavoriteTap(widget.post.id),
                      child: Icon(
                        widget.post.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildPreview(),
              SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye),
                      Text(widget.post.views.toString()),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.arrow_drop_up),
                      Text(widget.post.ups.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_drop_down),
                      Text(widget.post.downs.toString()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
