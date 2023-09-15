import 'package:dio/dio.dart';
import 'package:ghclient/services/github_api_service.dart';

class GitHubApiClient {

  GitHubApiService? _githubApiService;

  void initialize(Dio dio) {
    _githubApiService ??= GitHubApiService(dio);
  }

  GitHubApiService get githubApiService {
    if (_githubApiService == null) {
      throw Exception("GitHubApiService has not been initialized. Call 'initialize' first.");
    }
    return _githubApiService!;
  }

}
