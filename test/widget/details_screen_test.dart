import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/screens/detail/detail_cubit.dart';
import 'package:ghclient/screens/detail/detail_screen.dart';
import 'package:ghclient/services/models/repository.dart';
import 'package:bloc_test/bloc_test.dart';

class MockDetailPageCubit extends MockCubit<DetailPageState> implements DetailPageCubit {}

void main() {
  final mockRepository = Repository(
    name: 'Mock Repository',
    fullName: 'owner/repo',
    description: 'Mock Description',
    openIssuesCount: 10,
    stargazersCount: 100,
    language: 'Dart',
  );
  final mockState = DetailPageState(
    repository: mockRepository,
    pullRequestsCount: 5,
    prLoadingState: LoadingState.loaded,
  );

  group('DetailPage Widget Test', () {
    testWidgets('Renders DetailPage with mock data', (WidgetTester tester) async {
      final mockCubit = MockDetailPageCubit();

      whenListen<DetailPageState>(
        mockCubit,
        Stream.fromIterable([mockState]),
        initialState: mockState,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<DetailPageCubit>(
            create: (context) => mockCubit,
            child: const DetailPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(mockRepository.name), findsOneWidget);
      expect(find.text('Description:'), findsOneWidget);
      expect(find.text(mockRepository.description!), findsOneWidget);
      expect(find.text('Open Issues'), findsOneWidget);
      expect(find.text(mockRepository.openIssuesCount.toString()), findsOneWidget);
      expect(find.text('Stars'), findsOneWidget);
      expect(find.text(mockRepository.stargazersCount.toString()), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text(mockRepository.language!), findsOneWidget);
      expect(find.text('Pull requests'), findsOneWidget);
      expect(find.text(mockState.pullRequestsCount!.toString()), findsOneWidget);
    });
  });
}
