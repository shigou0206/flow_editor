abstract class IExecutionController {
  Future<void> runNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> stopNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> failNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> completeNode(String nodeId, {Map<String, dynamic>? data});

  Future<void> runWorkflow({Map<String, dynamic>? data});
  Future<void> cancelWorkflow({Map<String, dynamic>? data});
  Future<void> failWorkflow({Map<String, dynamic>? data});
  Future<void> completeWorkflow({Map<String, dynamic>? data});
}
