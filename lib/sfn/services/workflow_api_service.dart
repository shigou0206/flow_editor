import 'dart:convert';
import 'package:http/http.dart' as http;

class WorkflowApiService {
  final String baseUrl;
  final http.Client _client;

  WorkflowApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  // 1. 工作流模板管理

  /// 获取所有工作流模板
  Future<List<Map<String, dynamic>>> listTemplates(
      {int skip = 0, int limit = 100}) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workflow_templates/?skip=$skip&limit=$limit'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load templates: ${response.body}');
    }
  }

  /// 获取特定工作流模板
  Future<Map<String, dynamic>> getTemplate(String templateId) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workflow_templates/$templateId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load template: ${response.body}');
    }
  }

  /// 创建工作流模板
  Future<Map<String, dynamic>> createTemplate({
    required String name,
    String? description,
    required String dslDefinition,
    String? templateId,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/workflow_templates/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
        'dsl_definition': dslDefinition,
        'template_id': templateId,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create template: ${response.body}');
    }
  }

  /// 更新工作流模板
  Future<Map<String, dynamic>> updateTemplate({
    required String templateId,
    String? name,
    String? description,
    String? dslDefinition,
  }) async {
    final response = await _client.put(
      Uri.parse('$baseUrl/workflow_templates/$templateId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
        'dsl_definition': dslDefinition,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update template: ${response.body}');
    }
  }

  /// 删除工作流模板
  Future<void> deleteTemplate(String templateId) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl/workflow_templates/$templateId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete template: ${response.body}');
    }
  }

  // 2. 工作流执行管理

  /// 启动工作流执行
  Future<String> startWorkflow({
    required String templateId,
    String? workflowId,
    Map<String, dynamic>? input,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/workflow_executions/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'template_id': templateId,
        'workflow_id': workflowId,
        'input': input,
      }),
    );

    if (response.statusCode == 200) {
      // 假设响应中包含 run_id
      final data = jsonDecode(response.body);
      return data['run_id'];
    } else {
      throw Exception('Failed to start workflow: ${response.body}');
    }
  }

  /// 获取工作流执行状态
  Future<Map<String, dynamic>> getExecution(String runId) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workflow_executions/$runId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get execution: ${response.body}');
    }
  }

  /// 取消工作流执行
  Future<void> cancelWorkflow(String runId) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl/workflow_executions/$runId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel workflow: ${response.body}');
    }
  }

  /// 获取工作流执行的任务
  Future<List<Map<String, dynamic>>> getWorkflowTasks(String runId) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workflow_executions/$runId/tasks'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to get workflow tasks: ${response.body}');
    }
  }

  // 3. 工作流可视化

  /// 获取工作流可视化信息
  Future<Map<String, dynamic>> getWorkflowVisibility(String runId) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workflow_visibility/$runId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get workflow visibility: ${response.body}');
    }
  }

  /// 列出工作流可视化信息
  Future<List<Map<String, dynamic>>> listWorkflowVisibility({
    String? status,
    String? workflowType,
    int skip = 0,
    int limit = 100,
  }) async {
    final queryParams = <String, String>{};
    if (status != null) queryParams['status'] = status;
    if (workflowType != null) queryParams['workflow_type'] = workflowType;
    queryParams['skip'] = skip.toString();
    queryParams['limit'] = limit.toString();

    final uri = Uri.parse('$baseUrl/workflow_visibility/').replace(
      queryParameters: queryParams,
    );

    final response = await _client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to list workflow visibility: ${response.body}');
    }
  }

  // 4. 工作流事件

  /// 获取工作流执行的事件
  Future<List<Map<String, dynamic>>> getWorkflowEvents(String runId) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workflow_events/run/$runId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to get workflow events: ${response.body}');
    }
  }
}
