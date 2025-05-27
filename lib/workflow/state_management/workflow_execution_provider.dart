import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/execution/workflow_execution.dart';

final workflowExecutionProvider =
    StateProvider<WorkflowExecution?>((ref) => null);
