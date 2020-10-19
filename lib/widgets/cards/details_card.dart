import 'package:carousel_slider/carousel_slider.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/widgets/fullscreen_image.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatefulWidget {
  final Post post;
  final Function onFavoriteTap;
  final Function onVoteTap;

  const DetailsCard({
    Key key,
    @required this.post,
    @required this.onFavoriteTap,
    @required this.onVoteTap,
  }) : super(key: key);

  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: widget.post.images.map((image) {
                return Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImage(
                          imageUrl: image.link,
                          tag: 'image-${image.id}',
                        );
                      }))
                    },
                    child: Image.network(image.link),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: _toggleFavorite,
                  child: Icon(
                    widget.post.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
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
    );
  }
}
