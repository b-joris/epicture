import 'package:carousel_slider/carousel_slider.dart';
import 'package:epicture/widgets/fullscreen_image.dart';
import 'package:flutter/material.dart';
import 'package:epicture/models/image.dart' as Imgur;

Widget buildThumbnails(
  BuildContext context,
  List<Imgur.Image> images, {
  bool canFullscreen = false,
}) {
  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(enableInfiniteScroll: false),
        items: images.map((image) {
          return Builder(
            builder: (context) => canFullscreen
                ? GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImage(
                          imageUrl: image.link,
                          tag: 'image-${image.id}',
                        );
                      }))
                    },
                    child: Image.network(
                      image.link,
                      loadingBuilder: (context, child, loadgingProgress) {
                        if (loadgingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  )
                : Image.network(
                    image.link,
                    loadingBuilder: (context, child, loadgingProgress) {
                      if (loadgingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
          );
        }).toList(),
      ),
      SizedBox(height: 10),
      Container(
        width: images.length * 25.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: images
              .map(
                (_) => Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}
