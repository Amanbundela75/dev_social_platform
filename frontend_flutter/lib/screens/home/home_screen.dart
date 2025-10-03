import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/auth_service.dart';
import '../../api/feed_service.dart';
import '../../models/post_model.dart';
import '../../widgets/post_card.dart';
import 'create_post_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FeedService _feedService = FeedService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      _postsFuture = _feedService.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Feed"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authService.signOut();
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadPosts(),
        child: FutureBuilder<List<Post>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No posts yet. Be the first to post!"));
            }

            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Create Post Screen par jao
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
          // Agar post successfully create hua hai, to feed refresh karo
          if (result == true) {
            _loadPosts();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
