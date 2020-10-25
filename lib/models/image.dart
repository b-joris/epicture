/// Representation of an Image
class Image {
  final String id;
  final String title;
  final String description;
  final String type;
  final String link;
  bool isFavorite;

  Image({
    this.id,
    this.title,
    this.description,
    this.type,
    this.link,
    this.isFavorite,
  });

  /// Create a [Image] from the API data
  Image.fromJson(Map<String, dynamic> data)
      : this.id = data['id'],
        this.title = data['title'],
        this.description = data['description'],
        this.type = data['type'],
        this.link = data['link'],
        this.isFavorite = data['favorite'];
}
