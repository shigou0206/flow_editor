import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';

final currentDslProvider = StateProvider<WorkflowDSL?>((ref) => null);
