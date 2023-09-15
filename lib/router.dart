import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ghclient/screens/detail/detail_cubit.dart';
import 'package:ghclient/screens/detail/detail_screen.dart';
import 'package:ghclient/screens/main/main_cubit.dart';
import 'package:ghclient/screens/main/main_screen.dart';
import 'package:ghclient/services/models/repository.dart';

const String mainPage = '/';
const String detailPage = '/details';

final router = GoRouter(
  routes: [
    GoRoute(
      path: mainPage,
      builder: (context, state) => BlocProvider(
        create: (context) => MainPageCubit(),
        child: const MainPage(),
      ),
    ),
    GoRoute(
      path: detailPage,
      builder: (context, state) => BlocProvider(
        create: (context) => DetailPageCubit(repository: state.extra! as Repository),
        child: const DetailPage(),
      ),
    ),
  ],
);

class RouterHelper {
  static void pushDetail(Repository repository) => router.push(
        detailPage,
        extra: repository,
      );
}
