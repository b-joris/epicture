import 'dart:async';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/account_posts_repository.dart';

/// Bloc used for the communication between the API and the UI
class AccountPostsBloc {
  AccountPostsRepository _repository;
  StreamController _controller;

  /// When instantiate, it automatically call the [fetchAccountPosts] method
  AccountPostsBloc() {
    _repository = AccountPostsRepository();
    _controller = StreamController<Response<List<Post>>>();
    fetchAccountPosts();
  }

  dispose() {
    _controller?.close();
  }

  StreamSink<Response<List<Post>>> get accountPostsSink => _controller.sink;
  Stream<Response<List<Post>>> get accountPostsStream => _controller.stream;

  /// Fetch the posts informations for the current logged in user and send them via sink
  fetchAccountPosts() async {
    accountPostsSink.add(Response.loading('Getting AccountPosts Posts'));

    try {
      List<Post> posts = await _repository.fetchAccountPostsData();
      accountPostsSink.add(Response.completed(posts));
    } catch (exception) {
      accountPostsSink.add(Response.error(exception.toString()));
    }
  }
}
