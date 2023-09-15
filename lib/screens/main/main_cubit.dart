import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghclient/main.dart';
import 'package:ghclient/services/client.dart';
import 'package:ghclient/services/models/repository.dart';

const int _perPage = 30;

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(const MainPageState());

  CancelToken _cancelToken = CancelToken();
  int _currentPage = 0;

  Future<void> onQueryUpdated(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(loadingState: LoadingState.emptyQuery));
      return;
    } else {
      _currentPage = 0;
      emit(MainPageState.empty(query: query));
      await fetchNextPage();
    }
  }

  Future<void> fetchNextPage() async {
    if (state.loadingState == LoadingState.loading) return;

    _currentPage++;
    final query = state.query;

    if (_currentPage != 1 && _perPage * _currentPage > (state.result?.totalCount ?? 0)) {
      return;
    }

    _cancelToken = CancelToken();

    if (_currentPage == 1) {
      emit(state.copyWith(loadingState: LoadingState.loading));
    } else {
      emit(state.copyWith(loadingState: LoadingState.loadingMore));
    }

    try {
      final httpResponse =
          await di<GitHubApiClient>().githubApiService.searchRepositories(query, _currentPage, _cancelToken);

      if (httpResponse.response.statusCode == 200) {
        final RepositoryResponse repositories = httpResponse.data;
        final updatedItems = List<Repository>.from(state.result?.items ?? <Repository>[])..addAll(repositories.items);
        emit(state.copyWith(
          query: query,
          result: RepositoryResponse(items: updatedItems, totalCount: repositories.totalCount),
          loadingState: LoadingState.loaded,
        ));
      } else {
        emit(state.copyWith(
          loadingState: LoadingState.error,
          errorString: 'Error ${httpResponse.response.statusCode}',
        ));
      }
    } catch (e) {
      // Handle request cancellation or other errors here
      if (e is DioException && e.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print('Request canceled');
        }
      } else if (e is DioException) {
        emit(state.copyWith(loadingState: LoadingState.error, errorString: e.message));
      } else {
        emit(state.copyWith(loadingState: LoadingState.error, errorString: 'Error $e'));
      }
    }

    _cancelToken.cancel();
  }
}

class MainPageState extends Equatable {
  final String query;
  final RepositoryResponse? result;
  final LoadingState loadingState;
  final String? errorString;

  const MainPageState({
    this.query = '',
    this.result,
    this.errorString,
    this.loadingState = LoadingState.emptyQuery,
  });

  const MainPageState.empty({
    String? query,
  }) : this(
          query: query ?? '',
          result: null,
        );

  MainPageState copyWith({
    RepositoryResponse? result,
    LoadingState? loadingState,
    String? query,
    String? errorString,
  }) {
    return MainPageState(
      result: result ?? this.result,
      loadingState: loadingState ?? this.loadingState,
      query: query ?? this.query,
      errorString: errorString ?? this.errorString,
    );
  }

  @override
  List<Object?> get props => [query, result, loadingState, errorString];
}

enum LoadingState {
  emptyQuery,
  empty,
  loading,
  loadingMore,
  loaded,
  error,
}
