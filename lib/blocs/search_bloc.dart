import 'dart:async';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/search_repository.dart';

class SearchBloc {
  SearchRepository _repository;
  StreamController _controller;

  SearchBloc() {
    _repository = SearchRepository();
    _controller = StreamController<Response<List<Post>>>();
  }

  dispose() {
    _controller?.close();
  }

  StreamSink<Response<List<Post>>> get searchSink => _controller.sink;
  Stream<Response<List<Post>>> get searchStream => _controller.stream;

  fetchSearch(String query) async {
    searchSink.add(Response.loading('Getting Search Posts'));

    try {
      List<Post> posts = await _repository.fetchSearchData(query);
      searchSink.add(Response.completed(posts));
    } catch (exception) {
      searchSink.add(Response.error(exception.toString()));
    }
  }
}
