import 'package:epicture/repositories/interactions_repository.dart';

/// Bloc used for the communication between the API and the UI
///
/// For all the methods, the user must be connected
class InteractionsBloc {
  InteractionsRepository _repository;

  InteractionsBloc() {
    _repository = InteractionsRepository();
  }

  /// Toggle the favorite status of a secific [postID]
  Future<bool> toggleAlbumFavorite(String postID) async {
    try {
      final data = await _repository.toggleAlbumFavoriteData(postID);
      if (data['success']) return true;
    } catch (_) {
      return false;
    }
    return false;
  }

  /// Vote for a specific album
  ///
  /// [postID] is the albumod
  /// [vote] can be 'up' | 'down' | 'veto'
  Future<bool> voteForAlbum(
    String postID, {
    String vote,
  }) async {
    try {
      final data = await _repository.voteForAlbumData(postID, vote: vote);
      if (data['success']) return true;
    } catch (_) {
      return false;
    }
    return false;
  }

  /// Add a comment or a reply to a comment
  ///
  /// [imageID] is the image where you want to post the comment
  /// [comment] is the comment itself
  /// [parentID] have to be set if it's a reply to a comment
  Future<bool> addComment(
    String imageID,
    String comment, {
    int parentID = -1,
  }) async {
    try {
      final data = await _repository.addCommentData(
        imageID,
        comment,
        parentID: parentID,
      );
      if (data['success']) return true;
    } catch (_) {
      return false;
    }
    return false;
  }

  /// Update Imgur user's settings
  Future<bool> updateSetting({
    String username,
    String bio,
  }) async {
    try {
      final data = await _repository.updateSettingData(
        username: username,
        bio: bio,
      );
      if (data['success']) return true;
    } catch (_) {
      return false;
    }
    return false;
  }

  /// Upload a file to Imgur
  ///
  /// [encodedFile] is a base64 encoded file
  /// [isImage] define if the file is an image or video (only partially implemented)
  /// [title], [description] and [privacy] are optionnals
  /// [privacy] can be 'public' | 'private' | 'secret' (not used at the moment)
  Future<bool> uploadFile(
    String encodedFile,
    bool isImage, {
    String title,
    String description,
    String privacy,
  }) async {
    try {
      final data = await _repository.uploadFileData(
        encodedFile,
        isImage,
        title: title,
        description: description,
      );
      if (data['success']) return true;
    } catch (_) {
      return false;
    }
    return false;
  }
}
