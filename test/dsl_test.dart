// test/dsl_test.dart

import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';
import 'package:flow_editor/workflow/converters/graph_dsl_converter.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

void main() {
  final example = {
    "comment": "示例工作流：通过 HTTP 工具写入数据库，并根据返回码分支",
    "version": "1.0",
    "startAt": "PrepareData",
    "states": {
      "PrepareData": {
        "type": "pass",
        "outputMapping": {
          "mappings": [
            {"key": "name", "type": "constant", "value": "Alice"},
            {"key": "age", "type": "constant", "value": 30},
            {
              "key": "api_url",
              "type": "constant",
              "value": "https://example.com/api/users"
            }
          ]
        },
        "next": "SendData"
      },
      "SendData": {
        "type": "task",
        "resource": "http",
        "inputMapping": {
          "mappings": [
            {"key": "url", "type": "jsonPath", "source": "\$.api_url"},
            {"key": "method", "type": "constant", "value": "POST"},
            {
              "key": "headers",
              "type": "constant",
              "value": {"Content-Type": "application/json"}
            },
            {"key": "body", "type": "jsonPath", "source": "\$"}
          ]
        },
        "next": "CheckStatus"
      },
      "CheckStatus": {
        "type": "choice",
        "choices": [
          {
            "condition": {
              "and": [
                {
                  "variable": "\$.status",
                  "operator": "GreaterThanEquals",
                  "value": 200
                },
                {"variable": "\$.status", "operator": "LessThan", "value": 300}
              ]
            },
            "next": "Success"
          }
        ],
        "defaultNext": "Fail"
      },
      "Success": {"type": "succeed", "end": true},
      "Fail": {
        "type": "fail",
        "error": "HTTP request failed or returned non-2xx status",
        "end": true
      }
    }
  };

  final original = WorkflowDSL.fromJson(example);

  // 1) DSL→Graph
  final graph = DslGraphConverter.toGraph(original);

  // 2) Graph→DSL（传回 original 保留全量字段）
  final restored = GraphDslConverter.toDsl(
    original: original,
    nodes: (graph['nodes'] as List).cast<NodeModel>(),
    edges: (graph['edges'] as List).cast<EdgeModel>(),
    startAt: original.startAt,
  );

  print('=== Original DSL JSON ===');
  print(original.toJson());
  print('\n=== Restored DSL JSON ===');
  print(restored.toJson());
}
