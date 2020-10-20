import 'package:epicture/repositories/interactions_repository.dart';

class InteractionsBloc {
  InteractionsRepository _repository;

  InteractionsBloc() {
    _repository = InteractionsRepository();
  }

  Future<bool> addAlbumToFavorites(String postID) async {
    try {
      final data = await _repository.addAlbumToFavoritesData(postID);
      if (data['success']) return true;
    } catch (_) {
      return false;
    }
    return false;
  }

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

  // Future<bool> createAlbum(
  //   String encodedFile,
  //   bool isImage, {
  //   String title,
  //   String description,
  //   String privacy,
  // }) async {
  //   try {
  //     final albumCreationData = await _repository.createAlbumData(
  //       title: title,
  //       description: description,
  //       privacy: privacy,
  //     );
  //     if (!albumCreationData['success']) return false;
  //     print(albumCreationData);
  //     // final fileUploadData = await _repository.up
  //   } catch (exception) {
  //     print(exception);
  //     return false;
  //   }
  //   return false;
  // }
}
