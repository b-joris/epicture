import 'dart:async';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/account_posts_repository.dart';

class AccountPostsBloc {
  AccountPostsRepository _repository;
  StreamController _controller;

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
