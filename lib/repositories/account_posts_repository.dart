import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

/// Repository used to make the API call
class AccountPostsRepository {
  final _provider = ImgurProvider();

  /// Fetch the posts account for the logged user
  ///
  /// It can throw an [ImgurException]
  Future<List<Post>> fetchAccountPostsData({
    int page = 0,
  }) async {
    final data = await _provider.get('account/me/images/$page');
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)));
    return posts;
  }
}
