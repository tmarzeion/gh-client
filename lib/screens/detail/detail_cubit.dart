import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghclient/main.dart';
import 'package:ghclient/services/client.dart';
import 'package:ghclient/services/models/repository.dart';
import 'package:equatable/equatable.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  DetailPageCubit({required Repository repository}) : super(DetailPageState(repository: repository)) {
    fetchPullRequestCount();
  }

  Future<void> fetchPullRequestCount() async {
    try {
      final httpResponse = await di<GitHubApiClient>().githubApiService.getPullRequests(
            state.repository.fullName.split('/')[0],
            state.repository.fullName.split('/')[1],
          );

      if (httpResponse.response.statusCode == 200) {
        final int prCount = httpResponse.data.length;
        emit(state.copyWith(
          pullRequestsCount: prCount,
          prLoadingState: LoadingState.loaded,
        ));
      } else {
        emit(state.copyWith(
          prLoadingState: LoadingState.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(prLoadingState: LoadingState.error));
    }
  }
}

class DetailPageState extends Equatable {
  final Repository repository;
  final int? pullRequestsCount;
  final LoadingState prLoadingState;

  const DetailPageState({
    required this.repository,
    this.pullRequestsCount,
    this.prLoadingState = LoadingState.loading,
  });

  DetailPageState copyWith({
    Repository? repository,
    int? pullRequestsCount,
    LoadingState? prLoadingState,
  }) {
    return DetailPageState(
      repository: repository ?? this.repository,
      pullRequestsCount: pullRequestsCount ?? this.pullRequestsCount,
      prLoadingState: prLoadingState ?? this.prLoadingState,
    );
  }

  @override
  List<Object?> get props => [repository, pullRequestsCount, prLoadingState];
}

enum LoadingState {
  loading,
  loaded,
  error,
}
