// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/ui/flow_editor_test.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flow Editor Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const FlowEditorPage(),
    );
  }
}
