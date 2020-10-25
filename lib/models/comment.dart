/// Representation of a Comment
class Comment {
  final int id;
  final String imageID;
  final String comment;
  final String author;
  final int authorID;
  final List<Comment> responses;
  final String postID;

  Comment({
    this.id,
    this.imageID,
    this.comment,
    this.author,
    this.authorID,
    this.responses,
    this.postID,
  });

  /// Create a [Comment] from the API data
  factory Comment.fromJson(
    Map<String, dynamic> data, {
    String postID,
  }) {
    final int id = data['id'];
    final String imageID = data['image_id'];
    final String comment = data['comment'];
    final String author = data['author'];
    final int authorID = data['author_id'];

    final responses = List<Comment>.from(
      data['children']
          .where((data) => data is! String)
          .map((data) => Comment.fromJson(data)),
    );

    return Comment(
      id: id,
      imageID: imageID,
      comment: comment,
      author: author,
      authorID: authorID,
      responses: responses,
      postID: postID,
    );
  }
}
