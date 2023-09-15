import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable()
class RepositoryResponse {
  @JsonKey(name: 'total_count')
  final int totalCount;

  @JsonKey(name: 'items')
  final List<Repository> items;

  RepositoryResponse({
    required this.totalCount,
    required this.items,
  });

  factory RepositoryResponse.fromJson(Map<String, dynamic> json) => _$RepositoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryResponseToJson(this);
}

@JsonSerializable()
class Repository {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;

  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;

  @JsonKey(name: 'language')
  final String? language;

  Repository({
    required this.name,
    required this.fullName,
    required this.description,
    required this.openIssuesCount,
    required this.stargazersCount,
    required this.language,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}
