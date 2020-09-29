import 'package:epicture/constants.dart';
import 'package:epicture/models/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard(this.post, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    post.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: defaultPadding),
                  child: Icon(
                    post.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Image.network(
              post.images[0].link,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgess) {
                if (loadingProgess == null) return child;
                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.remove_red_eye),
                    Text(post.views.toString()),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.arrow_drop_up),
                    Text(post.ups.toString()),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.arrow_drop_down),
                    Text(post.downs.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
