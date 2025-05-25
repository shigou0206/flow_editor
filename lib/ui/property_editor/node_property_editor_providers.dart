// node_property_editor_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 使用family Provider，针对每个节点id分别存储选中的next节点列表
final choiceSelectedNextNodesProvider =
    StateProvider.family<List<String>, String>((ref, nodeId) => []);
