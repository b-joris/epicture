import 'package:epicture/networking/imgur_provider.dart';

class InteractionsRepository {
  final _provider = ImgurProvider();

  Future<Map<String, dynamic>> addAlbumToFavoritesData(String postID) async {
    final data = await _provider.post('album/$postID/favorite');
    return data;
  }

  Future<Map<String, dynamic>> voteForAlbumData(
    String postID, {
    String vote = '',
  }) async {
    final data = await _provider.post('gallery/$postID/vote/$vote');
    return data;
  }

  Future<Map<String, dynamic>> addCommentData(
    String imageID,
    String comment, {
    int parentID = -1,
  }) async {
    Map<String, dynamic> body = {
      'image_id': imageID,
      'comment': comment,
    };

    if (parentID != -1) {
      body = {
        ...body,
        'parent_id': parentID.toString(),
      };
    }

    final data = await _provider.post('comment', body: body);
    return data;
  }

  Future<Map<String, dynamic>> updateSettingData({
    String username,
    String bio,
  }) async {
    Map<String, dynamic> body = {};

    if (username != null) body['username'] = username;
    if (bio != null) body['bio'] = bio;

    final data = await _provider.post('account/me/settings', body: body);
    return data;
  }

  Future<Map<String, dynamic>> uploadFileData(
    String encodedFile,
    bool isImage, {
    String title,
    String description,
  }) async {
    Map<String, dynamic> body = {isImage ? 'image' : 'video': encodedFile};

    if (title != null) body['title'] = title;
    if (description != null) body['description'] = description;

    final data = await _provider.post('image', body: body);
    return data;
  }

  // Future<Map<String, dynamic>> createAlbumData({
  //   String title,
  //   String description,
  //   String privacy,
  // }) async {
  //   Map<String, dynamic> body = {};

  //   if (title != null) body['title'] = title;
  //   if (description != null) body['description'] = description;
  //   if (privacy != null) body['privacy'] = privacy;

  //   final data = await _provider.post('album');
  //   return data;
  // }
}
