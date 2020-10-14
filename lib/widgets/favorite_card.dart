import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FavoriteCard extends StatefulWidget {
  final Post post;
  final Function onFavoriteTap;

  const FavoriteCard({
    @required this.post,
    @required this.onFavoriteTap,
    Key key,
  }) : super(key: key);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  VideoPlayerController controller;

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildPreview() {
    print(widget.post.images[0].link);
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
                      widget.post.title,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
