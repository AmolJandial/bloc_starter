import 'dart:io';
import 'package:bloc_starter/features/infinite_list/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_starter/features/infinite_list/bloc/posts_bloc.dart';
import 'package:bloc_starter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteListPage extends StatelessWidget {
  const InfiniteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsBloc(http.Client())..add(PostFetched()),
      child: const InfiniteListView(),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostsBloc>().add(PostFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.infiniteTitle)),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.failure:
              return const Center(child: Text('Failed to fetch posts'));
            case PostStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.success:
              if (state.posts.isEmpty) {
                return Text('No more posts');
              }
              return ListView.separated(
                itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? const BottomLoader()
                      : PostListItem(post: state.posts[index]);
                },
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
