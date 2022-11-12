import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:mit_safari_app/posts/posts.dart';
import 'package:posts_repository/posts_repository.dart' hide Post;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._postRepository) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final PostsRepository _postRepository;

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final postFetch = await _postRepository.getPost();
        final postList = <Post>[];
        postFetch.asMap().forEach(
              (key, value) => {postList.add(Post.fromRepository(value))},
            );

        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: List.of(state.posts)..addAll(postList),
            hasReachedMax: false,
          ),
        );
      }
      final postFetch = await _postRepository.getPost(state.posts.length);
      final postList = <Post>[];
      postFetch.asMap().forEach(
            (key, value) => {postList.add(Post.fromRepository(value))},
          );
      postFetch.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(postList),
                hasReachedMax: false,
              ),
            );
    } catch (error) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
