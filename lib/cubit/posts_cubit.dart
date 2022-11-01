import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import '../repository/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsRepository postsRepository;

  PostsCubit(this.postsRepository)
      : super(
          PostsInitial(),
        );

  static PostsCubit get(context) => BlocProvider.of(context);

  Future<void> loadPosts() async {
    emit(const PostsLoading());
    try {
      final posts = await postsRepository.getPosts();
      emit(PostsLoaded(posts));
    } on Exception catch (e) {
      var string = e.toString();
      emit(const PostsError());
    }
  }
}
