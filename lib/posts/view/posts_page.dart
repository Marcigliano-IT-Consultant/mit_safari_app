import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mit_safari_app/posts/posts.dart';
import 'package:posts_repository/posts_repository.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => PostBloc(
          context.read<PostsRepository>(),
        )..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
