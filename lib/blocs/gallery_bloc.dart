import 'dart:async';

import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/repositories/gallery_repository.dart';

class GalleryBloc {
  GalleryRepository _repository;
  StreamController _controller;

  GalleryBloc() {
    _repository = GalleryRepository();
    _controller = StreamController<Response<List<Post>>>();
    fetchGallery();
  }

  dispose() {
    _controller?.close();
  }

  StreamSink<Response<List<Post>>> get gallerySink => _controller.sink;
  Stream<Response<List<Post>>> get galleryStream => _controller.stream;

  fetchGallery() async {
    gallerySink.add(Response.loading('Getting Gallery Posts'));

    try {
      List<Post> posts = await _repository.fetchGalleryData();
      gallerySink.add(Response.completed(posts));
    } catch (exception) {
      gallerySink.add(Response.error(exception.toString()));
    }
  }
}
