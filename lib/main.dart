import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ghclient/router.dart';
import 'package:ghclient/services/client.dart';

final di = GetIt.instance;

void setupLocator() {
  di.registerLazySingleton(() => GitHubApiClient());
}

void setupService() {
  final githubApiServiceLocator = di<GitHubApiClient>();
  githubApiServiceLocator.initialize(Dio());
}

void main() {
  setupLocator();
  setupService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}
