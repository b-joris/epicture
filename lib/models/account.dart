class Account {
  final String username;
  final String bio;
  final String avatar;

  Account({
    this.username,
    this.bio,
    this.avatar,
  });

  Account.fromJson(Map<String, dynamic> data)
      : this.username = data['url'],
        this.bio = data['bio'],
        this.avatar = data['avatar'];
}
