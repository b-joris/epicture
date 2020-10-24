import 'package:epicture/constants.dart';
import 'package:epicture/helpers/build_thumbnails.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GridPostCard extends StatefulWidget {
  final Post post;

  const GridPostCard({
    @required this.post,
    Key key,
  }) : super(key: key);

  @override
  _GridPostCardState createState() => _GridPostCardState();
}

class _GridPostCardState extends State<GridPostCard> {
  VideoPlayerController controller;

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
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
                ],
              ),
              SizedBox(height: 10),
              buildThumbnails(context, widget.post.images),
            ],
          ),
        ),
      ),
    );
  }
}
