import 'package:posts_with_unit_testing/models/post_model.dart';

import '../core/services/network_services.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final NetworkServices networkServices;

  RemoteDataSourceImpl(this.networkServices);

  @override
  Future<List<PostModel>> getPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await networkServices.get(url);

    if (response.statusCode != 200) throw Exception();

    final result = response.data as List;
    final posts = result.map((postMap) => PostModel.fromMap(postMap)).toList();
    return posts;
  }
}
