import 'package:epicture/blocs/gallery_bloc.dart';
import 'package:epicture/networking/response.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final _bloc = GalleryBloc();

  @override
  dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: StreamBuilder(
        stream: _bloc.galleryStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return Container();
              case Status.ERROR:
                return Container();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
