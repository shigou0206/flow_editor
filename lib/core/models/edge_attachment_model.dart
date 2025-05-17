import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/enums.dart';

class EdgeAttachmentModel {
  EdgeAttachmentModel({
    required this.id,
    required this.kind,
    required this.seg,
    required this.t,
    this.offset = Offset.zero,
    this.text,
    this.iconData,
  });

  // 基本参数 -------------------------------------------------------------
  final String id;
  final EdgeAttachmentKind kind;

  /// 对应 PathMetric 切片编号
  int seg;

  /// 在切片上的相对位置 0.0‥1.0
  double t;

  /// world = 基准点 + offset
  Offset offset;

  // 扩展参数 -------------------------------------------------------------
  final String? text; // label 用
  final IconData? iconData; // action 用

  // ----------------------------- JSON ----------------------------------
  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind.name,
        'seg': seg,
        't': t,
        'offset': [offset.dx, offset.dy],
        'text': text,
        'iconData': iconData?.codePoint,
      };

  factory EdgeAttachmentModel.fromJson(Map<String, dynamic> j) =>
      EdgeAttachmentModel(
        id: j['id'] as String,
        kind: EdgeAttachmentKind.values.firstWhere((e) => e.name == j['kind'],
            orElse: () => EdgeAttachmentKind.handle),
        seg: (j['seg'] as num).toInt(),
        t: (j['t'] as num).toDouble(),
        offset: Offset((j['offset'][0] as num).toDouble(),
            (j['offset'][1] as num).toDouble()),
        text: j['text'] as String?,
        iconData: j['iconData'] != null
            ? IconData(j['iconData'] as int, fontFamily: 'MaterialIcons')
            : null,
      );
}
