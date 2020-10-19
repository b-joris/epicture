import 'dart:async';

import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/comments_repository.dart';

class CommentsBloc {
  CommentsRepository _repository;
  StreamController _controller;

  CommentsBloc() {
    _repository = CommentsRepository();
    _controller = StreamController<Response<List<Comment>>>();
  }

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

  fetchComments(String postID) async {
    commentsSink.add(Response.loading('Getting Post Comments'));

    try {
      List<Comment> posts = await _repository.fetchCommentsData(postID);
      commentsSink.add(Response.completed(posts));
    } catch (exception) {
      commentsSink.add(Response.error(exception.toString()));
    }
  }

  fetchUserComments({
    String user = 'me',
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
