class Post {
  final int id;
  final String authorUsername;
  final String content;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.authorUsername,
    required this.content,
    required this.createdAt,
  });

  // JSON se Post object banane ke liye factory constructor
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      authorUsername: json['author_username'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
