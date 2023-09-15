import 'package:json_annotation/json_annotation.dart';

part 'pull_request.g.dart';

@JsonSerializable()
class PullRequest {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'body')
  final String? body;

  @JsonKey(name: 'created_at')
  final String createdAt;

  PullRequest({
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) => _$PullRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PullRequestToJson(this);
}
