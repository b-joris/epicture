import 'dart:core';

import 'package:epicture/models/image.dart' as Imgur;

class Post {
  final String id;
  final String title;
  final String link;
  final String accountUrl;
  final int views;
  final int ups;
  final int downs;
  final int commentCount;
  final List<Imgur.Image> images;

  Post({
    this.id,
    this.title,
    this.link,
    this.accountUrl,
    this.views,
    this.ups,
    this.downs,
    this.commentCount,
    this.images,
  });

  bool get isFavorite =>
      images[0].isFavorite == null ? false : images[0].isFavorite;
  set isFavorite(bool value) => images[0].isFavorite = value;

  factory Post.fromJson(Map<String, dynamic> data) {
    final images = data['images'];

    return Post(
      id: data['id'],
      title: data['title'],
      link: data['link'],
      accountUrl: data['account_url'],
      ups: data['ups'],
      downs: data['downs'],
      commentCount: data['comment_count'],
      views: data['views'],
      // isFavorite: data['favorite'] == null
      //     ? false
      //     : data['favorite']
      images: images == null
          ? [Imgur.Image(link: data['link'])]
          : List<Imgur.Image>.from(
              images.map(
                (image) => Imgur.Image.fromJson(image),
              ),
            ),
    );
  }
}
