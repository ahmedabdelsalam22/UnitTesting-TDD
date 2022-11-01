import '../data_sources/remote_data_source.dart';
import '../models/post_model.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts();
}

class PostsRepositoryImpl extends PostsRepository {
  final RemoteDataSource _remoteDataSource;

  PostsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PostModel>> getPosts() {
    return _remoteDataSource.getPosts();
  }
}
