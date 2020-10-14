import 'dart:async';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/favorites_repository.dart';

class FavoritesBloc {
  FavoritesRepository _repository;
  StreamController _controller;

  FavoritesBloc() {
    _repository = FavoritesRepository();
    _controller = StreamController<Response<List<Post>>>();
    fetchFavorites();
  }

  dispose() {
    _controller?.close();
  }

  StreamSink<Response<List<Post>>> get favoritesSink => _controller.sink;
  Stream<Response<List<Post>>> get favoritesStream => _controller.stream;

  fetchFavorites() async {
    favoritesSink.add(Response.loading('Getting Favorites Posts'));

    try {
      List<Post> posts = await _repository.fetchFavoritesData();
      favoritesSink.add(Response.completed(posts));
    } catch (exception) {
      favoritesSink.add(Response.error(exception.toString()));
    }
  }
}
