import 'dart:async';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/search_repository.dart';

/// Bloc used for the communication between the API and the UI
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

  /// Fetch the search and send them via sink
  fetchSearch(
    String query, {
    String sort = 'time',
    String window = 'all',
  }) async {
    searchSink.add(Response.loading('Getting Search Posts'));

    try {
      List<Post> posts =
          await _repository.fetchSearchData(query, sort: sort, window: window);
      searchSink.add(Response.completed(posts));
    } catch (exception) {
      searchSink.add(Response.error(exception.toString()));
    }
  }
}
