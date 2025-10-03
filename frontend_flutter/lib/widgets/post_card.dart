import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Date formatting ke liye (pubspec.yaml mein add karein)

import '../models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(post.authorUsername[0].toUpperCase()),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.authorUsername,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      // Date ko format karke dikhayenge
                      DateFormat.yMMMd()
                          .add_jm()
                          .format(post.createdAt.toLocal()),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              post.content,
              style: TextStyle(fontSize: 15),
            ),
            // Yahan future mein Like, Comment buttons aayenge
          ],
        ),
      ),
    );
  }
}
