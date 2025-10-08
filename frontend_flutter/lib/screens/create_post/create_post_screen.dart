import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../api/feed_service.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();
  final FeedService _feedService = FeedService();
  bool _isPosting = false;

  void _submitPost() async {
    if (_postController.text.isEmpty) return;

    setState(() { _isPosting = true; });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _feedService.createPost(_postController.text, user.uid);
        Navigator.of(context).pop(true); // Go back and signal success
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to post: $e")),
      );
    } finally {
      if (mounted) {
        setState(() { _isPosting = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          _isPosting
              ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0,)),
          )
              : TextButton(
            onPressed: _submitPost,
            child: Text("Post", style: TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _postController,
          autofocus: true,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: "What's happening in your dev world?",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
