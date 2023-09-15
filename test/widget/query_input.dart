import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/screens/main/widgets/query_input.dart';

void main() {

  testWidgets('QueryInputBox updates query on input', (WidgetTester tester) async {
    String query = '';
    await tester.pumpWidget(
      MaterialApp(
        home: QueryInputBox(
          onQueryChanged: (value) {
            query = value;
          },
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Test Query');

    // Wait for debounce timer to finish
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    expect(query, 'Test Query');
  });

  testWidgets('QueryInputBox clears query on clear button press', (WidgetTester tester) async {
    String query = '';
    await tester.pumpWidget(
      MaterialApp(
        home: QueryInputBox(
          onQueryChanged: (value) {
            query = value;
          },
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Test Query');

    // Wait for debounce timer to finish
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    expect(query, 'Test Query');

    await tester.tap(find.byIcon(Icons.clear));

    // Wait for debounce timer to finish
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    expect(query, '');
  });
}
