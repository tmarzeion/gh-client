import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghclient/screens/main/main_cubit.dart';
import 'package:ghclient/screens/main/widgets/query_input.dart';
import 'package:ghclient/screens/main/widgets/result_content.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of any input field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Simple GH client'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              QueryInputBox(
                onQueryChanged: (String value) {
                  context.read<MainPageCubit>().onQueryUpdated(value);
                },
              ),
              const ResultContent(),
            ],
          ),
        ),
      ),
    );
  }
}
