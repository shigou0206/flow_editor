// lib/core/controller/execution_controller_impl.dart

import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/exec/change_node_status_command.dart';
import 'package:flow_editor/core/command/exec/change_workflow_status_command.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';
import 'package:flow_editor/core/models/enums/execution_status.dart';
import 'package:flow_editor/core/controller/execution_controller_interface.dart';

class ExecutionControllerImpl implements IExecutionController {
  final CommandManager _mgr;
  final CommandContext _ctx;

  ExecutionControllerImpl(CommandContext ctx)
      : _ctx = ctx,
        _mgr = CommandManager(ctx);

  @override
  Future<void> runNode(String nodeId, {Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeNodeStatusCommand(_ctx, nodeId, NodeStatus.running,
            newData: data),
      );

  @override
  Future<void> stopNode(String nodeId, {Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeNodeStatusCommand(_ctx, nodeId, NodeStatus.cancelled,
            newData: data),
      );

  @override
  Future<void> failNode(String nodeId, {Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeNodeStatusCommand(_ctx, nodeId, NodeStatus.failed, newData: data),
      );

  @override
  Future<void> completeNode(String nodeId, {Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeNodeStatusCommand(_ctx, nodeId, NodeStatus.completed,
            newData: data),
      );

  @override
  Future<void> runWorkflow({Map<String, dynamic>? data}) => _mgr.executeCommand(
        ChangeWorkflowStatusCommand(
            _ctx, WorkflowStatus.running /*, newData?*/),
      );

  @override
  Future<void> cancelWorkflow({Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeWorkflowStatusCommand(
            _ctx, WorkflowStatus.cancelled /*, newData?*/),
      );

  @override
  Future<void> failWorkflow({Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeWorkflowStatusCommand(_ctx, WorkflowStatus.failed /*, newData?*/),
      );

  @override
  Future<void> completeWorkflow({Map<String, dynamic>? data}) =>
      _mgr.executeCommand(
        ChangeWorkflowStatusCommand(
            _ctx, WorkflowStatus.completed /*, newData?*/),
      );
}
