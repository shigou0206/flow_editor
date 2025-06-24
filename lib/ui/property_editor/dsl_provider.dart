import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/workflow/models/dsl/flow/workflow_dsl.dart';

final currentDslProvider = StateProvider<WorkflowDSL?>((ref) => null);
