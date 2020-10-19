import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ListPostCard extends StatefulWidget {
  final Post post;
  final Function onFavoriteTap;
  final Function onVoteTap;

  const ListPostCard({
    @required this.post,
    @required this.onFavoriteTap,
    @required this.onVoteTap,
    Key key,
  }) : super(key: key);

  @override
  _ListPostCardState createState() => _ListPostCardState();
}

class _ListPostCardState extends State<ListPostCard> {
  VideoPlayerController controller;

  @override
  dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _changeVote(String tapped) {
    String vote = '';

    if (tapped == 'up')
      vote = widget.post.vote == 'up' ? 'veto' : 'up';
    else
      vote = widget.post.vote == 'down' ? 'veto' : 'down';

    widget.onVoteTap(widget.post.id, vote: vote).then((isVoted) {
      if (isVoted) {
        setState(() {
          if (widget.post.vote == 'up') {
            widget.post.vote = vote;
            widget.post.ups -= 1;
            if (vote == 'down') widget.post.downs += 1;
          } else if (widget.post.vote == 'down') {
            widget.post.vote = vote;
            widget.post.downs -= 1;
            if (vote == 'up') widget.post.ups += 1;
          } else {
            widget.post.vote = vote;
            if (vote == 'up')
              widget.post.ups += 1;
            else
              widget.post.downs += 1;
          }
        });
      }
    });
  }

  void _toggleFavorite() {
    widget.onFavoriteTap(widget.post.id).then((isToggled) {
      if (isToggled)
        setState(() {
          this.widget.post.isFavorite = !this.widget.post.isFavorite;
        });
    });
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding),
                    child: GestureDetector(
                      onTap: _toggleFavorite,
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
                  GestureDetector(
                    onTap: () => _changeVote('up'),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_up,
                          color: widget.post.vote == 'up'
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.bodyText1.color,
                        ),
                        Text(widget.post.ups.toString()),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeVote('down'),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: widget.post.vote == 'down'
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.bodyText1.color,
                        ),
                        Text(widget.post.downs.toString()),
                      ],
                    ),
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
