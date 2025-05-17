import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/utils/coordinate_utils.dart';
import 'package:flutter/material.dart';

void main() {
  group('CoordinateUtils with nested nodes', () {
    const panParent = Offset(100, 50);
    const scaleParent = 1.5;

    // 子节点相对于父节点的本地坐标与缩放
    const panChild = Offset(20, 10);
    const scaleChild = 2.0;

    test('childLocalToParentWorld and inverse', () {
      const childLocal = Offset(5, 5);

      // childLocal -> world via childLocalToParentWorld
      final worldB = CoordinateUtils.childLocalToParentWorld(
          childLocal, panParent, scaleParent);

      // inverse back to child local
      final backLocal = CoordinateUtils.parentWorldToChildLocal(
          worldB, panParent, scaleParent);

      expect(backLocal.dx, closeTo(childLocal.dx, 1e-6));
      expect(backLocal.dy, closeTo(childLocal.dy, 1e-6));
    });

    test('nestedLocalToWorld matches chained childLocalToParentWorld', () {
      const localB = Offset(5, 5);
      const localC = Offset(-3, 2);

      // 手工链式：C -> B -> A
      final cInA = localB + localC * scaleChild; // C 在 A 本地
      final worldC = panParent + cInA * scaleParent; // C 在世界

      // nestedLocalToWorld 应给出同样的 worldC
      final origins = [localB, panParent]; // 注意第 0 层是 B 的本地偏移
      final scales = [scaleChild, scaleParent]; // 对应每层的 scale

      final nested =
          CoordinateUtils.nestedLocalToWorld(localC, origins, scales);

      expect(nested.dx, closeTo(worldC.dx, 1e-6));
      expect(nested.dy, closeTo(worldC.dy, 1e-6));
    });

    test('nestedWorldToLocal inverse of nestedLocalToWorld', () {
      const localP = Offset(8, -4);
      final origins = [panChild, panParent];
      final scales = [scaleChild, scaleParent];

      final world = CoordinateUtils.nestedLocalToWorld(localP, origins, scales);
      final back = CoordinateUtils.nestedWorldToLocal(world, origins, scales);

      expect(back.dx, closeTo(localP.dx, 1e-6));
      expect(back.dy, closeTo(localP.dy, 1e-6));
    });

    test(
        'single-level childLocalToParentWorld equals nestedLocalToWorld with one layer',
        () {
      const localP = Offset(7, 3);
      final worldSingle = CoordinateUtils.childLocalToParentWorld(
          localP, panParent, scaleParent);
      final nested = CoordinateUtils.nestedLocalToWorld(
          localP, [panParent], [scaleParent]);
      expect(nested, equals(worldSingle));
    });

    test('mismatched origins/scales lists assert', () {
      const localP = Offset(1, 1);
      expect(
        () => CoordinateUtils.nestedLocalToWorld(
            localP, [panParent], [scaleParent, scaleChild]),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => CoordinateUtils.nestedWorldToLocal(
            localP, [panParent, panChild], [scaleParent]),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
