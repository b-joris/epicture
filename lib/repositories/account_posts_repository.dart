import 'package:epicture/models/post.dart';
import 'package:epicture/networking/imgur_provider.dart';

class AccountPostsRepository {
  final _provider = ImgurProvider();

  Future<List<Post>> fetchAccountPostsData({
    int page = 0,
  }) async {
    final data = await _provider.get('account/me/images/$page');
    final posts =
        List<Post>.from(data['data'].map((data) => Post.fromJson(data)));
    return posts;
  }
}
