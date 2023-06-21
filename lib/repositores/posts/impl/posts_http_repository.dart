import 'dart:convert';

import 'package:trilhaapp/model/posts_model.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/repositores/posts/posts_repository.dart';

class PostsHttpRepository implements PostsRepository {

  @override
  Future<List<PostsModel>> getPosts() async {
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode==200) {
      var json = jsonDecode(response.body);
      //List<PostsModel> posts = json.map((post)=>PostsModel.fromJson(post)).toList();
      var posts = (json as List).map((e) => PostsModel.fromJson(e)).toList();
      return posts;
    }
    return [];
  }

}