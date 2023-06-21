import '../../model/posts_model.dart';

abstract class PostsRepository {

  Future<List<PostsModel>> getPosts();
}