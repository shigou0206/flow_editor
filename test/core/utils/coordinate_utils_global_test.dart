// test/utils/coordinate_utils_global_test.dart

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/utils/coordinate_utils.dart';
import 'package:flutter/material.dart';

/// 一个最简的 StubBox，只重写了 globalToLocal/localToGlobal
class StubBox extends RenderBox {
  final Offset offset;
  StubBox(this.offset);

  @override
  Offset globalToLocal(Offset global, {RenderObject? ancestor}) =>
      global - offset;

  @override
  Offset localToGlobal(Offset local, {RenderObject? ancestor}) =>
      local + offset;

  @override
  void performLayout() {
    size = Size.zero;
  }
}

void main() {
  group('CoordinateUtils.global/local with StubBox', () {
    const boxOffset = Offset(3, 7);
    final box = StubBox(boxOffset);

    test('globalToLocal should subtract box offset', () {
      const global = Offset(10, 20);
      // stub: local = global - offset
      final local = CoordinateUtils.globalToLocal(box, global);
      expect(local, equals(global - boxOffset));
    });

    test('localToGlobal should add box offset', () {
      const local = Offset(1, 2);
      // stub: global = local + offset
      final global = CoordinateUtils.localToGlobal(box, local);
      expect(global, equals(local + boxOffset));
    });

    test('globalToWorld uses globalToLocal then localToWorld', () {
      const global = Offset(13, 17);
      const pan = Offset(5, 5);
      const scale = 2.0;
      // step1: local = global - offset  = (10,10)
      // step2: world = (local - pan)/scale = ((10,10)-(5,5))/2 = (2.5,2.5)
      final world = CoordinateUtils.globalToWorld(box, global, pan, scale);
      expect(world, equals(const Offset(2.5, 2.5)));
    });

    test('worldToGlobal uses worldToLocal then localToGlobal', () {
      const world = Offset(4, 8);
      const pan = Offset(1, 2);
      const scale = 4.0;
      // step1: local = world*scale + pan = (16,32)+(1,2) = (17,34)
      // step2: global = local + offset = (17,34)+(3,7) = (20,41)
      final global = CoordinateUtils.worldToGlobal(box, world, pan, scale);
      expect(global, equals(const Offset(20, 41)));
    });
  });
}
