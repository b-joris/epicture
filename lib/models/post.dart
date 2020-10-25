import 'dart:core';

import 'package:epicture/models/image.dart' as Imgur;

/// Representation of a Post
class Post {
  final String id;
  final String title;
  final String link;
  final String accountUrl;
  final int views;
  final int commentCount;
  final List<Imgur.Image> images;
  int ups;
  int downs;
  bool isFavorite;
  String vote;

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
    this.vote,
    this.isFavorite,
  });

  /// Create a [Post] from the API data
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
      isFavorite: data['favorite'] == null ? false : data['favorite'],
      vote: data['vote'],
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
