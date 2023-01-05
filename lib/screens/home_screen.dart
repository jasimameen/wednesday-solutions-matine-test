import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];

  getPosts() async {
    final dio = Dio();
    final responce =
        await dio.get("https://jsonplaceholder.typicode.com/posts");

    // (responce.data as List).forEach((post) {
    //   posts.add(Post.fromMap(post));
    // });

    setState(() {
      posts = (responce.data as List).map((map) => Post.fromMap(map)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Posts")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PhysicalModel(
              color: Colors.white,
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                trailing: IconButton(
                  icon: const Icon(
                    CupertinoIcons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    posts.removeAt(index);
                    setState(() {});
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          getPosts();
        },
      ),
    );
  }
}
