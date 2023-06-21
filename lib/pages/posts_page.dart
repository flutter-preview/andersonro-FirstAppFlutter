import 'package:flutter/material.dart';
import 'package:trilhaapp/model/posts_model.dart';
import 'package:trilhaapp/repositores/posts/impl/posts_dio_repository.dart';
import 'package:trilhaapp/repositores/posts/posts_repository.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  PostsRepository postsRepository = PostsDioRepository();
  var posts = <PostsModel>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  void getPosts() async {
    setState(() {
      isLoading = true;
    });

    posts = await postsRepository.getPosts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Posts"),),
          body: isLoading ?
                  Container() :
                  ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (_, index) {
                        var post = posts[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Card(
                            elevation: 4,
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        post.title.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(post.body.toString(),
                                    )
                                  ],
                                )
                            ),
                          ),
                        );
                  }),
        )
    );
  }
}
