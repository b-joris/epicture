import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/imgur_provider.dart';

class CommentsRepository {
  final _provider = ImgurProvider();

  Future<List<Comment>> fetchCommentsData(
    String postID, {
    String sort = 'best',
  }) async {
    final data = await _provider.get('gallery/$postID/comments/$sort');
    final comments = List<Comment>.from(
        data['data'].map((data) => Comment.fromJson(data, postID: postID)));
    return comments;
  }

  Future<List<Comment>> fetchUserCommentsData({
    String user = 'me',
    String commentSort = 'newest',
    int page = 0,
  }) async {
    final data =
        await _provider.get('account/$user/comments/$commentSort/$page');
    final comments =
        List<Comment>.from(data['data'].map((data) => Comment.fromJson(data)));
    return comments;
  }
}
