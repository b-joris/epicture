import 'dart:async';

import 'package:epicture/models/comment.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/comments_repository.dart';

class CommentsBloc {
  CommentsRepository _repository;
  StreamController _controller;

  CommentsBloc(String postID) {
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
      List<Comment> posts = await _repository.fetchComments(postID);
      commentsSink.add(Response.completed(posts));
    } catch (exception) {
      commentsSink.add(Response.error(exception.toString()));
    }
  }
}
