import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/main.dart';
import 'package:ghclient/router.dart';
import 'package:ghclient/screens/main/main_screen.dart';
import 'package:ghclient/screens/detail/detail_screen.dart';
import 'package:ghclient/services/models/repository.dart';

void main() {
  testWidgets('Navigate to main page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    expect(find.byType(MainPage), findsOneWidget);
  });

  testWidgets('Navigate to detail page', (WidgetTester tester) async {
    final repository = Repository(
      name: 'Some name',
      fullName: 'some/fullname',
      description: 'Some description',
      openIssuesCount: 12,
      stargazersCount: 4321,
      language: 'Dart',
    );

    await tester.pumpWidget(const MyApp());

    RouterHelper.pushDetail(repository);

    await tester.pumpAndSettle();

    expect(find.byType(DetailPage), findsOneWidget);
  });
}
