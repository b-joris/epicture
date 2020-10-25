import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

class SearchRepository {
  final _provider = ImgurProvider();

  Future<List<Post>> fetchSearchData(
    String query, {
    String sort = 'time',
    String window = 'all',
  }) async {
    final data = await _provider.get('gallery/search/$sort/$window?q=$query');
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)))
            .where((post) => !post.images[0].link.contains('mp4'))
            .toList();
    return posts;
  }
}
