import 'dart:io';

import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

class SearchRepository {
  final _provider = ImgurProvider();

  Future<List<Post>> fetchSearchData(
    String query, {
    String sort = 'time',
    String window = 'all',
  }) async {
    final data = await _provider.get(
      'gallery/search/$sort/$window?q=$query',
      headers: {
        HttpHeaders.authorizationHeader: 'Client-ID $clientID',
      },
    );
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)));
    return posts;
  }
}
