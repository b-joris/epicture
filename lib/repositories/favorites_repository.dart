import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

class FavoritesRepository {
  final _provider = ImgurProvider();

  Future<List<Post>> fetchFavoritesData({
    int page = 0,
    String sort = 'newest',
  }) async {
    final data =
        await _provider.get('account/me/gallery_favorites/$page/$sort');
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)))
            .where((post) => !post.images[0].link.contains('mp4'))
            .toList();
    return posts;
  }
}
