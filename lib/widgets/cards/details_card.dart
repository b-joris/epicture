import 'package:carousel_slider/carousel_slider.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/widgets/fullscreen_image.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  final Post post;

  const DetailsCard({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: post.images.map((image) {
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
          ],
        ),
      ),
    );
  }
}
