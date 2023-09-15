import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghclient/screens/detail/detail_cubit.dart';
import 'package:ghclient/screens/detail/widgets/info_item.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPageCubit, DetailPageState>(
      builder: (context, state) {
        final repository = state.repository;
        return Scaffold(
          appBar: AppBar(
            title: Text(repository.name),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      repository.description ?? 'No description available',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16.0),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        InfoItem(
                          icon: Icons.error_outline,
                          iconColor: Colors.red,
                          title: 'Open Issues',
                          value: repository.openIssuesCount.toString(),
                        ),
                        InfoItem(
                          icon: Icons.star_border_outlined,
                          iconColor: Colors.amber,
                          title: 'Stars',
                          value: repository.stargazersCount.toString(),
                        ),
                        InfoItem(
                          icon: Icons.code_sharp,
                          iconColor: Colors.blue,
                          title: 'Language',
                          value: repository.language,
                        ),
                        InfoItem(
                          icon: Icons.merge_type,
                          iconColor: Colors.green,
                          title: 'Pull requests',
                          value: state.pullRequestsCount?.toString(),
                          loading: state.prLoadingState == LoadingState.loading,
                          error: state.prLoadingState == LoadingState.error,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
