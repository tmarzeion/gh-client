import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/dio.dart';
import 'package:ghclient/main.dart';
import 'package:ghclient/screens/detail/detail_cubit.dart';
import 'package:ghclient/services/client.dart';
import 'package:ghclient/services/github_api_service.dart';
import 'package:ghclient/services/models/pull_request.dart';
import 'package:ghclient/services/models/repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'detail_cubit_test.mocks.dart';

@GenerateMocks([GitHubApiService, GitHubApiClient])
void main() {
  final mockApiService = MockGitHubApiService();
  final mockApiClient = MockGitHubApiClient();

  const owner = 'owner';
  const repo = 'repo';
  final sampleRepository = Repository(
    name: 'Some name',
    fullName: '$owner/$repo',
    description: 'Some description',
    openIssuesCount: 12,
    stargazersCount: 4321,
    language: 'Dart',
  );

  final samplePullRequest = PullRequest(
    title: 'title',
    body: 'body',
    createdAt: 'createdAt',
  );
  final samplePullRequestsResponseData = [
    samplePullRequest,
    samplePullRequest,
    samplePullRequest,
  ];

  setUp(() {
    di.registerSingleton<GitHubApiClient>(mockApiClient);
    when(mockApiClient.githubApiService).thenReturn(mockApiService);
  });

  tearDown(() {
    di.reset();
  });

  group('DetailPageCubit', () {

    blocTest<DetailPageCubit, DetailPageState>(
      'emits loaded states when fetchPullRequestCount is successful',
      build: () {
        when(mockApiService.getPullRequests(owner, repo)).thenAnswer(
          (_) async => HttpResponse<List<PullRequest>>(
            samplePullRequestsResponseData,
            Response(
              data: samplePullRequestsResponseData,
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        );

        return DetailPageCubit(repository: sampleRepository);
      },
      act: (cubit) => cubit.fetchPullRequestCount(),
      expect: () => [
        DetailPageState(
          repository: sampleRepository,
          pullRequestsCount: samplePullRequestsResponseData.length,
          prLoadingState: LoadingState.loaded,
        ),
      ],
    );

    blocTest<DetailPageCubit, DetailPageState>(
      'emits loading and error states when fetchPullRequestCount fails',
      build: () {
        when(mockApiService.getPullRequests(owner, repo)).thenAnswer(
              (_) async => HttpResponse<List<PullRequest>>(
            [],
            Response(
              data: null,
              requestOptions: RequestOptions(),
              statusCode: 500,
            ),
          ),
        );

        return DetailPageCubit(repository: sampleRepository);
      },
      act: (cubit) => cubit.fetchPullRequestCount(),
      expect: () => [
        DetailPageState(
          repository: sampleRepository,
          prLoadingState: LoadingState.error,
        ),
      ],
    );
  });
}
