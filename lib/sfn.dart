import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sfn/node_sidebar.dart';
import 'sfn/step_function_canvas_bk.dart';

void main() {
  runApp(const ProviderScope(child: StepFunctionLayoutApp()));
}

class StepFunctionLayoutApp extends StatelessWidget {
  const StepFunctionLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StepFunction Layout Demo'),
        ),
        body: const Row(
          children: [
            SizedBox(width: 200, child: NodeSidebar()),
            Expanded(child: StepFunctionCanvas()),
          ],
        ),
      ),
    );
  }
}
