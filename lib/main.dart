import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/state_management/providers/theme_provider.dart';
import 'core/models/enums.dart';
import 'widgets/workflow_canvas.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeKey = ref.watch(themeProvider);
    final themedata = themeKey.data(true); // Material3 = true

    return MaterialApp(
      title: 'Flow Editor',
      theme: themedata,
      darkTheme: AppTheme.dark.data(true),
      home: const Scaffold(body: WorkflowCanvas(workflowId: 'wf')),
    );
  }
}
