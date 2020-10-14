import 'package:epicture/blocs/gallery_bloc.dart';
import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:epicture/networking/response.dart';
import 'package:epicture/widgets/navigation/action_button.dart';
import 'package:epicture/widgets/navigation/navigation_bar.dart';
import 'package:epicture/widgets/cards/list_post_card.dart';
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
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ActionButton(),
      bottomNavigationBar: NavigationBar(pageNumber: 0),
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchGallery(),
        child: StreamBuilder(
          stream: _bloc.galleryStream,
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
                          onFavoriteTap: _bloc.addAlbumToFavorites,
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
