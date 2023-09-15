import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ghclient/screens/main/main_cubit.dart';
import 'package:ghclient/screens/main/main_screen.dart';
import 'package:ghclient/services/models/repository.dart';

class MockMainPageCubit extends MockCubit<MainPageState> implements MainPageCubit {}

void main() {
  final mockRepo = Repository(
    name: 'Some name 1',
    fullName: 'owner/repo',
    description: 'Some description',
    openIssuesCount: 12,
    stargazersCount: 4321,
    language: 'Dart',
  );

  testWidgets('Renders MainPage with mock data', (WidgetTester tester) async {
    final mockCubit = MockMainPageCubit();

    whenListen<MainPageState>(
      mockCubit,
      Stream.fromIterable([
        const MainPageState(
          query: 'mockQuery',
          loadingState: LoadingState.loading,
        ),
        MainPageState(
          query: 'mockQuery',
          loadingState: LoadingState.loaded,
          result: RepositoryResponse(
            items: [
              mockRepo,
            ],
            totalCount: 1,
          ),
        )
      ]),
      initialState: const MainPageState(
        loadingState: LoadingState.emptyQuery,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MainPageCubit>(
          create: (context) => mockCubit,
          child: const MainPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Simple GH client'), findsOneWidget);
    expect(find.text('Some name 1'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('4.3k'), findsOneWidget);
  });
}
