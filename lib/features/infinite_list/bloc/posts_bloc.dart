import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_starter/features/infinite_list/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

const throttleDuration = Duration(milliseconds: 100);
const _postLimit = 20;
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (event, mapper) {
    return droppable<E>().call(event.throttle(duration), mapper);
  };
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(this._httpClient) : super(PostsState()) {
    on<PostFetched>(_onPostFetched, transformer: throttleDroppable(throttleDuration));
  }

  final http.Client _httpClient;

  /// `onPostFetched` event is called when user reached the new eand of a list

  void _onPostFetched(PostFetched event, Emitter<PostsState> emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      final posts = await _fetchPosts(startIndex: state.posts.length);
      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }
      emit(state.copyWith(status: PostStatus.success, posts: [...state.posts, ...posts]));
    } catch (e, stack) {
      debugPrint('error _onPostFetched $e \n stack -> $stack');
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts({required int startIndex}) async {
    final response = await _httpClient.get(
      Uri.parse('http://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$_postLimit'),
    );
    debugPrint('response -> ${response.statusCode}');
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
