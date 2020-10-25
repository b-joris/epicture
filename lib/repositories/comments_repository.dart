import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/imgur_provider.dart';

/// Repository used to make the API call
class CommentsRepository {
  final _provider = ImgurProvider();

  /// Fetch the comments for a post
  /// [postID] is the specific ID for a post
  /// [sort] can be 'best' | 'top' | 'new'
  ///
  /// It can throw an [ImgurException]
  Future<List<Comment>> fetchCommentsData(
    String postID, {
    String sort = 'best',
  }) async {
    final data = await _provider.get('gallery/$postID/comments/$sort');
    final comments = List<Comment>.from(
        data['data'].map((data) => Comment.fromJson(data, postID: postID)));
    return comments;
  }

  /// Fetch the comments for a post
  /// [username] can be either an Imgur's username or 'me' for the logged user
  /// [commentSort] can be 'best' | 'worst' | 'oldest' | 'newest'
  ///
  /// It can throw an [ImgurException]
  Future<List<Comment>> fetchUserCommentsData({
    String username = 'me',
    String commentSort = 'newest',
    int page = 0,
  }) async {
    final data =
        await _provider.get('account/$username/comments/$commentSort/$page');
    final comments =
        List<Comment>.from(data['data'].map((data) => Comment.fromJson(data)));
    return comments;
  }
}
