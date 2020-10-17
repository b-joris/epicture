class Comment {
  final int id;
  final String imageID;
  final String comment;
  final String author;
  final int authorID;
  final List<Comment> responses;

  Comment({
    this.id,
    this.imageID,
    this.comment,
    this.author,
    this.authorID,
    this.responses,
  });

  factory Comment.fromJson(Map<String, dynamic> data) {
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
    );
  }
}
