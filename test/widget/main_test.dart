import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ghclient/main.dart';
import 'package:ghclient/services/client.dart';

void main() {
  testWidgets('Service and locator setup test', (WidgetTester tester) async {
    setupLocator();
    setupService();

    await tester.pumpWidget(const MyApp());

    final githubApiClient = GetIt.instance<GitHubApiClient>();

    expect(githubApiClient, isNotNull);
    expect(githubApiClient.githubApiService, isNotNull);
  });
}
