import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ghclient/services/models/pull_request.dart';
import 'package:ghclient/services/models/repository.dart';

part 'github_api_service.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class GitHubApiService {
  factory GitHubApiService(Dio dio, {String baseUrl}) = _GitHubApiService;

  @GET('/search/repositories')
  Future<HttpResponse<RepositoryResponse>> searchRepositories(
    @Query('q') String query,
    @Query('page') int page, [
    @CancelRequest() CancelToken? cancelToken,
  ]);

  @GET('/repos/{owner}/{repo}/pulls')
  Future<HttpResponse<List<PullRequest>>> getPullRequests(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );
}
