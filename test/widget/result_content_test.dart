import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghclient/screens/main/main_cubit.dart';
import 'package:ghclient/screens/main/widgets/result_content.dart';
import 'package:ghclient/screens/main/widgets/state_indicators_widgets.dart';
import 'package:ghclient/services/models/repository.dart';
import 'package:bloc_test/bloc_test.dart';

class MockMainPageCubit extends MockCubit<MainPageState> implements MainPageCubit {}

void main() {
  group('ResultContent Widget Test', () {
    testWidgets('Renders ResultContent with loaded state', (WidgetTester tester) async {
      final mockRepo = Repository(
        name: 'Some name 1',
        fullName: 'owner/repo',
        description: 'Some description',
        openIssuesCount: 12,
        stargazersCount: 4321,
        language: 'Dart',
      );

      final mockRepositories = [mockRepo];
      final mockState = MainPageState(
          loadingState: LoadingState.loaded, result: RepositoryResponse(items: mockRepositories, totalCount: 1));

      final mockCubit = MockMainPageCubit();
      whenListen(
        mockCubit,
        Stream.fromIterable([mockState]),
        initialState: const MainPageState(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MainPageCubit>(
            create: (context) => mockCubit,
            child: Material(
              child: Column(
                children: const [
                  ResultContent(),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(EmptyStateContent), findsNothing);
      expect(find.byType(LoadingStateContent), findsNothing);
      expect(find.byType(LoadingMoreIndicator), findsNothing);
      expect(find.byType(EmptyQueryStateContent), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Renders ResultContent with loading state', (WidgetTester tester) async {
      const mockState = MainPageState(loadingState: LoadingState.loading);

      final mockCubit = MockMainPageCubit();
      whenListen(
        mockCubit,
        Stream.fromIterable([mockState]),
        initialState: const MainPageState(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MainPageCubit>(
            create: (context) => mockCubit,
            child: Material(
              child: Column(
                children: const [
                  ResultContent(),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(EmptyStateContent), findsNothing);
      expect(find.byType(LoadingStateContent), findsOneWidget);
      expect(find.byType(LoadingMoreIndicator), findsNothing);
      expect(find.byType(EmptyQueryStateContent), findsNothing);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('Renders ResultContent with error state', (WidgetTester tester) async {
      const mockState = MainPageState(loadingState: LoadingState.error, errorString: 'Custom error message');

      final mockCubit = MockMainPageCubit();
      whenListen(
        mockCubit,
        Stream.fromIterable([mockState]),
        initialState: const MainPageState(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MainPageCubit>(
            create: (context) => mockCubit,
            child: Material(
              child: Column(
                children: const [
                  ResultContent(),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EmptyStateContent), findsNothing);
      expect(find.byType(LoadingStateContent), findsNothing);
      expect(find.byType(LoadingMoreIndicator), findsNothing);
      expect(find.text('Custom error message'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('Renders ResultContent with emptyQuery state', (WidgetTester tester) async {
      const mockState = MainPageState(loadingState: LoadingState.emptyQuery);

      final mockCubit = MockMainPageCubit();
      whenListen(
        mockCubit,
        Stream.fromIterable([mockState]),
        initialState: const MainPageState(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MainPageCubit>(
            create: (context) => mockCubit,
            child: Material(
              child: Column(
                children: const [
                  ResultContent(),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EmptyStateContent), findsNothing);
      expect(find.byType(LoadingStateContent), findsNothing);
      expect(find.byType(LoadingMoreIndicator), findsNothing);
      expect(find.byType(EmptyQueryStateContent), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
  });
}
