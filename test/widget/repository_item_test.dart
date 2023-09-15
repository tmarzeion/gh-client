import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/common/utils.dart';
import 'package:ghclient/screens/main/widgets/repository_item.dart';

void main() {
  testWidgets('RepositoryItem displays name and stars', (WidgetTester tester) async {
    await tester.pumpWidget(
      Material(
        child: MaterialApp(
          home: RepositoryItem(
            name: 'Test Repository',
            stars: 100,
            language: 'Dart',
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Test Repository'), findsOneWidget);
    expect(find.text(shortenNumber(100)), findsOneWidget);
  });

  testWidgets('RepositoryItem displays description when provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      Material(
        child: MaterialApp(
          home: RepositoryItem(
            name: 'Test Repository',
            stars: 100,
            language: 'Dart',
            description: 'This is a test repository description.',
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('This is a test repository description.'), findsOneWidget);
  });

  testWidgets('RepositoryItem displays language when provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      Material(
        child: MaterialApp(
          home: RepositoryItem(
            name: 'Test Repository',
            stars: 100,
            language: 'Dart',
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Dart'), findsOneWidget);
  });

  testWidgets('RepositoryItem does not display description when null', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: RepositoryItem(
            name: 'Test Repository',
            stars: 100,
            language: 'Dart',
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('This is a test repository description.'), findsNothing);
  });

  testWidgets('RepositoryItem does not display language when null', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: RepositoryItem(
            name: 'Test Repository',
            stars: 100,
            onTap: () {},
            language: null,
          ),
        ),
      ),
    );

    expect(find.text('Dart'), findsNothing);
  });
}
