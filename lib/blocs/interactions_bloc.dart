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
}
