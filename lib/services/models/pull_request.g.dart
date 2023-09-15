// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PullRequest _$PullRequestFromJson(Map<String, dynamic> json) => PullRequest(
      title: json['title'] as String,
      body: json['body'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$PullRequestToJson(PullRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'created_at': instance.createdAt,
    };
