import '../../anchor/models/anchor_model.dart';
import 'node_model.dart';
import 'node_enums.dart';

/// WorkflowNodeModel
///
/// 继承自 NodeModel，保留父类的字段和功能，
/// 并新增专属字段 (flowId, taskName) 供自动化流程使用。
class WorkflowNodeModel extends NodeModel {
  /// 子类新增字段示例
  final String flowId;
  final String taskName;

  /// 构造函数：显式调用父类 NodeModel 的所有必填字段
  /// 并在此定义子类新增字段。
  WorkflowNodeModel({
    // ------------- 父类必填字段 -------------
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.type,
    required super.title,
    required super.anchors,
    // ------------- 父类可选字段 -------------
    super.dragMode,
    super.role,
    super.status,
    super.parentId,
    super.zIndex,
    super.enabled,
    super.locked,
    super.description,
    super.style,
    super.version,
    super.createdAt,
    super.updatedAt,
    super.inputs,
    super.outputs,
    super.config,
    super.data,
    // ------------- 子类新增字段 -------------
    this.flowId = '',
    this.taskName = '',
  }) : super(
        // 省略，父类构造已在参数声明中注入
        );

  /// 子类 copyWith：返回同类型 (WorkflowNodeModel) 的新实例
  /// 可以更新子类新增字段 (flowId, taskName)
  @override
  WorkflowNodeModel copyWith({
    // 父类字段
    double? x,
    double? y,
    double? width,
    double? height,
    String? type,
    String? title,
    List<AnchorModel>? anchors,
    DragMode? dragMode,
    NodeRole? role,
    NodeStatus? status,
    String? parentId,
    int? zIndex,
    bool? enabled,
    bool? locked,
    String? description,
    NodeStyle? style,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? inputs,
    Map<String, dynamic>? outputs,
    Map<String, dynamic>? config,
    Map<String, dynamic>? data,
    // 子类新增
    String? flowId,
    String? taskName,
  }) {
    return WorkflowNodeModel(
      id: id, // 父类 NodeModel 的 id 保持不变
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      type: type ?? this.type,
      title: title ?? this.title,
      anchors: anchors ?? this.anchors,
      dragMode: dragMode ?? this.dragMode,
      role: role ?? this.role,
      status: status ?? this.status,
      parentId: parentId ?? this.parentId,
      zIndex: zIndex ?? this.zIndex,
      enabled: enabled ?? this.enabled,
      locked: locked ?? this.locked,
      description: description ?? this.description,
      style: style ?? this.style,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      inputs: inputs ?? this.inputs,
      outputs: outputs ?? this.outputs,
      config: config ?? this.config,
      data: data ?? this.data,
      // 子类新增字段
      flowId: flowId ?? this.flowId,
      taskName: taskName ?? this.taskName,
    );
  }

  /// 子类的 toJson，可以在父类的 toJson 上进行二次处理
  @override
  Map<String, dynamic> toJson() {
    // 先调用父类方法
    final baseJson = super.toJson();

    // 再添加/覆盖子类字段
    baseJson.addAll({
      'flowId': flowId,
      'taskName': taskName,
    });

    return baseJson;
  }

  /// 子类 fromJson：如果需要从JSON反序列化时自动识别是子类
  /// 你也可单独写一个 static 方法来创建 WorkflowNodeModel
  factory WorkflowNodeModel.fromJson(Map<String, dynamic> json) {
    // 先用 NodeModel.fromJson 解析父类字段
    final baseModel = NodeModel.fromJson(json);

    // 将 baseModel 中的必填字段解构到子类
    return WorkflowNodeModel(
      id: baseModel.id,
      x: baseModel.x,
      y: baseModel.y,
      width: baseModel.width,
      height: baseModel.height,
      type: baseModel.type,
      title: baseModel.title,
      anchors: baseModel.anchors,
      dragMode: baseModel.dragMode,
      role: baseModel.role,
      status: baseModel.status,
      parentId: baseModel.parentId,
      zIndex: baseModel.zIndex,
      enabled: baseModel.enabled,
      locked: baseModel.locked,
      description: baseModel.description,
      style: baseModel.style,
      version: baseModel.version,
      createdAt: baseModel.createdAt,
      updatedAt: baseModel.updatedAt,
      inputs: baseModel.inputs,
      outputs: baseModel.outputs,
      config: baseModel.config,
      data: baseModel.data,
      // 子类字段: 如果json里没有就用默认值
      flowId: json['flowId'] as String? ?? '',
      taskName: json['taskName'] as String? ?? '',
    );
  }
}
