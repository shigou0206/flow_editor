import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 所有 Canvas 相关命令都实现此接口
abstract class CanvasCommand {
  /// 执行
  void execute(WidgetRef ref);

  /// 撤销
  void undo(WidgetRef ref);
}
