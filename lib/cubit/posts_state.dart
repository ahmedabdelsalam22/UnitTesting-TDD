part of 'posts_cubit.dart';

abstract class PostsStates {
  const PostsStates();
}

class PostsInitial extends PostsStates {}

class PostsLoading extends PostsStates {
  const PostsLoading();
}

class PostsLoaded extends PostsStates {
  final List<PostModel> posts;

  const PostsLoaded(this.posts);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostsLoaded && listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}

class PostsError extends PostsStates {
  final String? message;

  const PostsError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
