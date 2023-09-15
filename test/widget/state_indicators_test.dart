import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/screens/main/widgets/state_indicators_widgets.dart';

void main() {
  group('LoadingMoreIndicator', () {
    testWidgets('should build without error', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoadingMoreIndicator()));
      expect(find.byType(LoadingMoreIndicator), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });

  group('EmptyStateContent', () {
    testWidgets('should build without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: const [
              EmptyStateContent(),
            ],
          ),
        ),);
      expect(find.byType(EmptyStateContent), findsOneWidget);
      expect(find.text('No results found'), findsOneWidget);
    });
  });

  group('EmptyQueryStateContent', () {
    testWidgets('should build without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: const [
              EmptyQueryStateContent(),
            ],
          ),
        ),
      );
      expect(find.byType(EmptyQueryStateContent), findsOneWidget);
      expect(find.text('Type query to get started'), findsOneWidget);
    });
  });

  group('ErrorStateContent', () {
    testWidgets('should build without error', (WidgetTester tester) async {
      const errorString = 'Test error message';
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: const [
              ErrorStateContent(errorString: errorString),
            ],
          ),
        ),
      );
      expect(find.byType(ErrorStateContent), findsOneWidget);
      expect(find.text(errorString), findsOneWidget);
    });
  });

  group('LoadingStateContent', () {
    testWidgets('should build without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: const [
              LoadingStateContent(),
            ],
          ),
        ),
      );
      expect(find.byType(LoadingStateContent), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
