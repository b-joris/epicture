import 'dart:io';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

import '../main.dart';

class FavoritesRepository {
  final _provider = ImgurProvider();
  final _accessToken = sharedPreferences.get('access_token');

  Future<List<Post>> fetchFavoritesData({
    int page = 0,
    String sort = 'newest',
  }) async {
    final data = await _provider.get(
      'account/me/gallery_favorites/$page/$sort',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_accessToken',
      },
    );
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)));
    return posts;
  }
}
