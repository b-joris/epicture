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
}
