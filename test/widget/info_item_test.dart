import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/screens/detail/widgets/info_item.dart';

void main() {
  testWidgets('InfoItem displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: InfoItem(
          icon: Icons.info,
          iconColor: Colors.blue,
          title: 'Test Title',
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
  });

  testWidgets('InfoItem displays value when not loading or in error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: InfoItem(
          icon: Icons.info,
          iconColor: Colors.blue,
          title: 'Test Title',
          value: 'Test Value',
        ),
      ),
    );

    expect(find.text('Test Value'), findsOneWidget);
  });

  testWidgets('InfoItem displays loading indicator when loading', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: InfoItem(
          icon: Icons.info,
          iconColor: Colors.blue,
          title: 'Test Title',
          loading: true,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('InfoItem displays error icon when in error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: InfoItem(
          icon: Icons.info,
          iconColor: Colors.blue,
          title: 'Test Title',
          value: 'Test Value',
          error: true,
        ),
      ),
    );

    expect(find.byIcon(Icons.info), findsOneWidget);

    expect(find.text('Test Value'), findsNothing);
  });
}
