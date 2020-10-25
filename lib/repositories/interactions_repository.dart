import 'package:epicture/networking/imgur_provider.dart';

/// Repository used to make the interactions
class InteractionsRepository {
  final _provider = ImgurProvider();

  /// Toggle the favorite for the [postID]'s album
  ///
  /// It can throw an [ImgurException]
  Future<Map<String, dynamic>> toggleAlbumFavoriteData(String postID) async {
    final data = await _provider.post('album/$postID/favorite');
    return data;
  }

  /// Vote for a specific album
  ///
  /// [postID] is the albumod
  /// [vote] can be 'up' | 'down' | 'veto'
  ///
  /// It can throw an [ImgurException]
  Future<Map<String, dynamic>> voteForAlbumData(
    String postID, {
    String vote = '',
  }) async {
    final data = await _provider.post('gallery/$postID/vote/$vote');
    return data;
  }

  /// Add a comment or a reply to a comment
  ///
  /// [imageID] is the image where you want to post the comment
  /// [comment] is the comment itself
  /// [parentID] have to be set if it's a reply to a comment
  ///
  /// It can throw an [ImgurException]
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

  /// Update Imgur's user settings
  ///
  /// It can throw an [ImgurException]
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

  /// Upload a file to Imgur
  ///
  /// [encodedFile] is a base64 encoded file
  /// [isImage] define if the file is an image or video (only partially implemented)
  /// [title], [description] are optionnals
  ///
  /// It can throw an [ImgurException]
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
}
