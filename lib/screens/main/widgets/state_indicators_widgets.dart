import 'package:flutter/material.dart';

class LoadingMoreIndicator extends StatelessWidget {
  const LoadingMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: LinearProgressIndicator(),
    );
  }
}

class EmptyStateContent extends StatelessWidget {
  const EmptyStateContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text('No results found'),
      ),
    );
  }
}

class EmptyQueryStateContent extends StatelessWidget {
  const EmptyQueryStateContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text('Type query to get started'),
      ),
    );
  }
}

class ErrorStateContent extends StatelessWidget {
  const ErrorStateContent({required this.errorString, super.key});

  final String errorString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(errorString, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class LoadingStateContent extends StatelessWidget {
  const LoadingStateContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
