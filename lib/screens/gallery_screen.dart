import 'package:epicture/blocs/gallery_bloc.dart';
import 'package:epicture/blocs/interactions_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/helpers/add_post.dart';
import 'package:epicture/main.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/cards/list_post_card.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final _galleryBloc = GalleryBloc();
  final _interactionsBloc = InteractionsBloc();
  final _accessToken = sharedPreferences.get('access_token');

  @override
  dispose() {
    _galleryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      floatingActionButton: _accessToken != null
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add an Image'),
              onPressed: () => addPost(context),
              foregroundColor: Colors.white,
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () => _galleryBloc.fetchGallery(),
        child: StreamBuilder(
          stream: _galleryBloc.galleryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  final List<Post> posts = snapshot.data.data;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: ListPostCard(
                          post: posts[index],
                          onFavoriteTap: _interactionsBloc.toggleAlbumFavorite,
                          onVoteTap: _interactionsBloc.voteForAlbum,
                        ),
                      );
                    },
                  );
                case Status.ERROR:
                  return Center(child: Text('Error while loading posts'));
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
