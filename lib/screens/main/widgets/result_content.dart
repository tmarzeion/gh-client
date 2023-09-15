import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghclient/router.dart';
import 'package:ghclient/screens/main/main_cubit.dart';
import 'package:ghclient/screens/main/widgets/repository_item.dart';
import 'package:ghclient/screens/main/widgets/state_indicators_widgets.dart';
import 'package:ghclient/services/models/repository.dart';

class ResultContent extends StatefulWidget {
  const ResultContent({super.key});

  @override
  State<ResultContent> createState() => _ResultContentState();
}

class _ResultContentState extends State<ResultContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        switch (state.loadingState) {
          case LoadingState.empty:
            return const EmptyStateContent();
          case LoadingState.loading:
            return const LoadingStateContent();
          case LoadingState.loaded:
          case LoadingState.loadingMore:
            if (state.result != null && state.result!.items.isNotEmpty) {
              return Expanded(
                child: Stack(
                  children: [
                    if (state.loadingState == LoadingState.loadingMore) const LoadingMoreIndicator(),
                    LoadedStateContent(state.result!.items)
                  ],
                ),
              );
            } else {
              return const EmptyStateContent();
            }
          case LoadingState.error:
            return ErrorStateContent(errorString: state.errorString ?? 'Error');
          case LoadingState.emptyQuery:
            return const EmptyQueryStateContent();
        }
      },
    );
  }
}

class LoadedStateContent extends StatefulWidget {
  const LoadedStateContent(this.repositories, {super.key});

  final List<Repository> repositories;

  @override
  State<LoadedStateContent> createState() => _LoadedStateContentState();
}

class _LoadedStateContentState extends State<LoadedStateContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has scrolled to the end, fetch the next page
      context.read<MainPageCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: widget.repositories.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 2,
          thickness: 2,
        );
      },
      itemBuilder: (context, index) {
        final item = widget.repositories[index];
        return RepositoryItem(
          name: item.name,
          description: item.description,
          stars: item.stargazersCount,
          language: item.language,
          onTap: () {
            FocusScope.of(context).unfocus();
            RouterHelper.pushDetail(item);
          },
        );
      },
    );
  }
}
