import 'dart:async';

import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/comments_repository.dart';

/// Bloc used for the communication between the API and the UI
class CommentsBloc {
  CommentsRepository _repository;
  StreamController _controller;

  CommentsBloc() {
    _repository = CommentsRepository();
    _controller = StreamController<Response<List<Comment>>>();
  }

  /// When instantiate with the [CommentsBloc.fromPost], it use the [postID] to automatically fetch the data for this comment
  CommentsBloc.fromPost(String postID) {
    _repository = CommentsRepository();
    _controller = StreamController<Response<List<Comment>>>();
    fetchComments(postID);
  }

  dispose() {
    _controller?.close();
  }

  StreamSink<Response<List<Comment>>> get commentsSink => _controller.sink;
  Stream<Response<List<Comment>>> get commentsStream => _controller.stream;

  /// Fetch the post comments and send them via sink
  fetchComments(String postID) async {
    commentsSink.add(Response.loading('Getting Post Comments'));

    try {
      List<Comment> posts = await _repository.fetchCommentsData(postID);
      commentsSink.add(Response.completed(posts));
    } catch (exception) {
      commentsSink.add(Response.error(exception.toString()));
    }
  }

  /// Fetch the user comments and send them via sink
  /// [username] can be either an Imgur's username or 'me' for the current logged user
  fetchUserComments({
    String username = 'me',
  }) async {
    commentsSink.add(Response.loading('Getting User Comments'));

    try {
      List<Comment> comments = await _repository.fetchUserCommentsData();
      commentsSink.add(Response.completed(comments));
    } catch (exception) {
      commentsSink.add(Response.error(exception.toString()));
    }
  }
}
