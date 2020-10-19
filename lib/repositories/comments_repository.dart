import 'dart:io';

import 'package:epicture/constants.dart';
import 'package:epicture/main.dart';
import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/imgur_provider.dart';

class CommentsRepository {
  final _provider = ImgurProvider();
  final _accessToken = sharedPreferences.get('access_token');

  Future<List<Comment>> fetchCommentsData(
    String postID, {
    String sort = 'best',
  }) async {
    final data = await _provider.get(
      'gallery/$postID/comments/$sort',
      headers: {
        HttpHeaders.authorizationHeader: _accessToken != null
            ? 'Bearer $_accessToken'
            : 'Client-ID: $clientID',
      },
    );
    final comments = List<Comment>.from(
        data['data'].map((data) => Comment.fromJson(data, postID: postID)));
    return comments;
  }

  Future<List<Comment>> fetchUserCommentsData({
    String user = 'me',
    String commentSort = 'newest',
    int page = 0,
  }) async {
    final data = await _provider.get(
      'account/$user/comments/$commentSort/$page',
      headers: {
        HttpHeaders.authorizationHeader: _accessToken != null
            ? 'Bearer $_accessToken'
            : 'Client-ID: $clientID',
      },
    );
    final comments =
        List<Comment>.from(data['data'].map((data) => Comment.fromJson(data)));
    return comments;
  }
}
