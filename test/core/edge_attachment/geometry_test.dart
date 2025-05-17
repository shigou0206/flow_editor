import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/models/edge_attachment_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/enums.dart';
import 'package:flow_editor/core/utils/edge_utils.dart';
import 'dart:ui';

void main() {
  test('attachments stay on curve after rebuild', () {
    final edge = EdgeModel(
      start: Offset.zero,
      end: const Offset(100, 0),
      attachments: [
        EdgeAttachmentModel(
          id: 'h',
          kind: EdgeAttachmentKind.handle,
          seg: 0,
          t: .5,
        )
      ],
    );

    final path = Path()
      ..moveTo(0, 0)
      ..cubicTo(0, 50, 100, -50, 100, 0); // 只有 1 段

    BezierUtils.lockAttachments(edge, path);

    final att = edge.attachments.first;
    final ms = path.computeMetrics().toList();

    // seg 应落在合法区间 [0, metrics.length - 1]
    expect(att.seg, inInclusiveRange(0, ms.length - 1));

    // world 坐标距离曲线 ≤ 0.5 px
    final w =
        ms[att.seg].getTangentForOffset(ms[att.seg].length * att.t)!.position +
            att.offset;
    expect((w - const Offset(50, 0)).distance, lessThan(0.5));
  });
}
