import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class FeedService {
  final String _baseUrl = "http://10.0.2.2:8000/api/v1/";

  // Saare posts fetch karne ke liye
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}posts/'));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Post> posts =
            body.map((dynamic item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      print("Error fetching posts: $e");
      rethrow;
    }
  }

  // Naya post create karne ke liye
  Future<Post> createPost(String content, String authorUid) async {
    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}posts/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'content': content,
          'author': authorUid, // Yahan hum author ka UID bhej rahe hain
        }),
      );

      if (response.statusCode == 201) {
        // 201 means 'Created'
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to create post: ${response.body}");
      }
    } catch (e) {
      print("Error creating post: $e");
      rethrow;
    }
  }
}
