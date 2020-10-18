import 'dart:io';

import 'package:epicture/networking/imgur_provider.dart';

import '../main.dart';

class InteractionsRepository {
  final _provider = ImgurProvider();
  final _accessToken = sharedPreferences.get('access_token');

  Future<Map<String, dynamic>> addAlbumToFavoritesData(String postID) async {
    final data = await _provider.post(
      'album/$postID/favorite',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_accessToken',
      },
    );
    return data;
  }

  Future<Map<String, dynamic>> voteForAlbumData(
    String postID, {
    String vote,
  }) async {
    final data = await _provider.post(
      'gallery/$postID/vote/$vote',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_accessToken',
      },
    );
    return data;
  }
}
