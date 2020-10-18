import 'dart:io';

import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

import '../main.dart';

class GalleryRepository {
  final _provider = ImgurProvider();
  final _accessToken = sharedPreferences.get('access_token');

  Future<List<Post>> fetchGalleryData({
    String section = 'hot',
    bool showViral = true,
    bool showMature = false,
  }) async {
    final data = await _provider.get(
      'gallery/$section?showViral=$showViral&mature=$showMature&album_previews=false',
      headers: {
        HttpHeaders.authorizationHeader: _accessToken != null
            ? 'Bearer $_accessToken'
            : 'Client-ID: $clientID',
      },
    );
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)))
            .where((post) => !post.images[0].link.contains('mp4'))
            .toList();
    return posts;
  }
}
