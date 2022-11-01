import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/network_services.dart';
import '../cubit/posts_cubit.dart';
import '../data_sources/remote_data_source.dart';
import '../models/post_model.dart';
import '../repository/posts_repository.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
        PostsRepositoryImpl(
          RemoteDataSourceImpl(NetworkServiceImpl()),
        ),
      )..loadPosts(),
      child: SafeArea(
        child: Scaffold(body: _buildBody(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsStates>(
      listener: (context, state) {
        if (state is PostsError) _showErrorDialog(context);
      },
      builder: (context, state) {
        if (state is PostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoaded) {
          return _buildPostsList(state);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPostsList(PostsLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: state.posts.length,
        itemBuilder: (_, index) {
          final post = state.posts[index];
          return _PostItem(post);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            color: Colors.grey,
            height: 0.5,
          );
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('An error occurred!'),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final PostModel _post;

  const _PostItem(this._post);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(_post.id.toString()),
      title: Text(_post.title),
      subtitle: Text(_post.body),
    );
  }
}
