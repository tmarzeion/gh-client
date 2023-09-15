import 'dart:async';
import 'package:flutter/material.dart';

class QueryInputBox extends StatefulWidget {
  final ValueChanged<String> onQueryChanged;
  final Duration queryDebounceTime;

  const QueryInputBox({
    Key? key,
    required this.onQueryChanged,
    this.queryDebounceTime = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  QueryInputBoxState createState() => QueryInputBoxState();
}

class QueryInputBoxState extends State<QueryInputBox> {
  late final TextEditingController controller;
  late String lastQuery;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    lastQuery = controller.text;
    controller.addListener(() {
      if (lastQuery == controller.text) {
        return;
      }
      lastQuery = controller.text;
      _debounceTimer?.cancel();
      if (controller.text.isEmpty) {
        widget.onQueryChanged('');
        return;
      }
      _debounceTimer = Timer(widget.queryDebounceTime, () {
        widget.onQueryChanged(controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final hslColor = HSLColor.fromColor(primaryColor);
    final newHslColor = HSLColor.fromAHSL(
      primaryColor.alpha / 255.0,
      hslColor.hue,
      hslColor.saturation,
      0.95,
    ).toColor();

    return Card(
      color: newHslColor,
      margin: const EdgeInsets.all(0),
      elevation: 4,
      shadowColor: newHslColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search repositories...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _debounceTimer?.cancel();
                controller.clear();
                widget.onQueryChanged(controller.text);
              },
            ),
          ),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
