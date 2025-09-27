part of 'posts_bloc.dart';

enum PostStatus { initial, success, failure }

final class PostsState extends Equatable {
  const PostsState({
    this.posts = const <Post>[],
    this.status = PostStatus.initial,
    this.hasReachedMax = false,
  });

  final List<Post> posts;
  final PostStatus status;
  final bool hasReachedMax;

  @override
  List<Object> get props => [posts, status, hasReachedMax];

  PostsState copyWith({List<Post>? posts, PostStatus? status, bool? hasReachedMax}) {
    return PostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
