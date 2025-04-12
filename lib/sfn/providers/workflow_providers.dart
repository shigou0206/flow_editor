import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/workflow_api_service.dart';
import '../models.dart';

// API 服务提供者
final workflowApiServiceProvider = Provider<WorkflowApiService>((ref) {
  return WorkflowApiService(baseUrl: 'http://your-api-base-url');
});

// 工作流模板列表提供者
final workflowTemplatesProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final apiService = ref.watch(workflowApiServiceProvider);
  return apiService.listTemplates();
});

// 当前选中的模板 ID
final selectedTemplateIdProvider = StateProvider<String?>((ref) => null);

// 当前选中的模板详情
final selectedTemplateProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final templateId = ref.watch(selectedTemplateIdProvider);
  if (templateId == null) return null;

  final apiService = ref.watch(workflowApiServiceProvider);
  return apiService.getTemplate(templateId);
});

// 当前工作流执行 ID
final currentRunIdProvider = StateProvider<String?>((ref) => null);

// 当前工作流执行状态
final workflowExecutionProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final runId = ref.watch(currentRunIdProvider);
  if (runId == null) return null;

  final apiService = ref.watch(workflowApiServiceProvider);
  return apiService.getExecution(runId);
});

// 工作流执行任务
final workflowTasksProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final runId = ref.watch(currentRunIdProvider);
  if (runId == null) return [];

  final apiService = ref.watch(workflowApiServiceProvider);
  return apiService.getWorkflowTasks(runId);
});

// 工作流执行事件
final workflowEventsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final runId = ref.watch(currentRunIdProvider);
  if (runId == null) return [];

  final apiService = ref.watch(workflowApiServiceProvider);
  return apiService.getWorkflowEvents(runId);
});

// 工作流可视化信息
final workflowVisibilityProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final runId = ref.watch(currentRunIdProvider);
  if (runId == null) return null;

  final apiService = ref.watch(workflowApiServiceProvider);
  return apiService.getWorkflowVisibility(runId);
});
