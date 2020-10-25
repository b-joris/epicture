import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

/// Repository used to make the API call
class GalleryRepository {
  final _provider = ImgurProvider();

  /// Fetch the gallery images
  ///
  /// [section] can be 'hot' | 'top' | 'user'
  ///
  /// It can throw an [ImgurException]
  Future<List<Post>> fetchGalleryData({
    String section = 'hot',
    bool showViral = true,
    bool showMature = false,
  }) async {
    final data = await _provider.get(
        'gallery/$section?showViral=$showViral&mature=$showMature&album_previews=false');
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)))
            .where((post) => !post.images[0].link.contains('mp4'))
            .toList();
    return posts;
  }
}
