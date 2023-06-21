import 'package:trilhaapp/model/posts_model.dart';
import 'package:trilhaapp/repositores/jsonplaceholder_custon_dio.dart';
import 'package:trilhaapp/repositores/posts/posts_repository.dart';

class PostsDioRepository implements PostsRepository {

  @override
  Future<List<PostsModel>> getPosts() async {
    //var url = "https://jsonplaceholder.typicode.com/posts";
    var url = "/posts";
    var jsonPlaceHolderCustonDio = JsonPlaceHolderCustonDio();
    var response = await jsonPlaceHolderCustonDio.dio.get(url);
    if (response.statusCode==200) {
      //var json = jsonDecode(response.data);
      //List<PostsModel> posts = json.map((post)=>PostsModel.fromJson(post)).toList();
      var posts = (response.data as List).map((e) => PostsModel.fromJson(e)).toList();
      return posts;
    }
    return [];
  }

}