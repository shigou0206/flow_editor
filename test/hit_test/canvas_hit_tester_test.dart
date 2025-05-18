import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';

/// A fake implementation of CanvasHitTester that allows us to inject
/// controlled return values for each individual hitTestXxx method.
class FakeHitTester extends CanvasHitTester {
  final String? anchorResult;
  final String? nodeResult;
  final String? edgeResult;

  FakeHitTester({
    this.anchorResult,
    this.nodeResult,
    this.edgeResult,
  });

  @override
  String? hitTestAnchor(Offset pos) => anchorResult;

  @override
  String? hitTestNode(Offset pos) => nodeResult;

  @override
  String? hitTestEdge(Offset pos) => edgeResult;
}

void main() {
  group('CanvasHitTester.hitTestElement', () {
    test('returns anchor when hitTestAnchor is non-null, regardless of others',
        () {
      final tester = FakeHitTester(
        anchorResult: 'anchor1',
        nodeResult: 'node1',
        edgeResult: 'edge1',
      );

      final result = tester.hitTestElement(const Offset(10, 10));
      expect(result, 'anchor1', reason: 'anchor should have highest priority');
    });

    test('returns node when anchor misses but node hits', () {
      final tester = FakeHitTester(
        anchorResult: null,
        nodeResult: 'node42',
        edgeResult: 'edgeX',
      );

      final result = tester.hitTestElement(const Offset(5, 5));
      expect(result, 'node42',
          reason: 'node should be returned when anchor misses');
    });

    test('returns edge when both anchor and node miss but edge hits', () {
      final tester = FakeHitTester(
        anchorResult: null,
        nodeResult: null,
        edgeResult: 'edge999',
      );

      final result = tester.hitTestElement(const Offset(0, 0));
      expect(result, 'edge999',
          reason: 'edge should be returned when anchor/node miss');
    });

    test('returns null when none hit', () {
      final tester = FakeHitTester(
        anchorResult: null,
        nodeResult: null,
        edgeResult: null,
      );

      final result = tester.hitTestElement(const Offset(123, 456));
      expect(result, isNull, reason: 'should return null when nothing is hit');
    });
  });
}
