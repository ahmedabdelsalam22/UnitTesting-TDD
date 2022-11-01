import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_with_unit_testing/core/services/network_services.dart';
import 'package:posts_with_unit_testing/data_sources/remote_data_source.dart';
import 'package:posts_with_unit_testing/models/post_model.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([NetworkServices])
void main() {
  late RemoteDataSourceImpl remoteDataSourceImpl;
  late NetworkServices mockNetworkServices;

  // this method initially called before any unitTest default by flutter.

  setUp(() {
    mockNetworkServices = MockNetworkServices();
    remoteDataSourceImpl = RemoteDataSourceImpl(mockNetworkServices);
  });

  test('this method called getPosts should return List of Posts without exp',
      () async {
    //arrange
    final posts = List.generate(
        5,
        (index) => PostModel(
            id: index,
            userId: index,
            title: 'title $index',
            body: 'body $index'));

    final postMap = posts.map((post) => post.toMap()).toList();
    when(mockNetworkServices.get('https://jsonplaceholder.typicode.com/posts'))
        .thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts'),
          data: postMap,
          statusCode: 200,
        ),
      ),
    );

    //act
    final result = await remoteDataSourceImpl.getPosts();

    //assert
    expect(result, posts);
  });

  test('GetPosts should throw an Exception if the status code is not 200',
      () async {
    //arrange
    final expectedResult = throwsA(isA<Exception>());
    when(mockNetworkServices.get('https://jsonplaceholder.typicode.com/posts'))
        .thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(
              path: 'https://jsonplaceholder.typicode.com/posts'),
          statusCode: 404,
        ),
      ),
    );

    //act
    final result = () async => await remoteDataSourceImpl.getPosts();

    //assert
    expect(result, expectedResult);
  });
}
