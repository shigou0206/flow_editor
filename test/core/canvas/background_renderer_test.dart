import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flow_editor/core/canvas/renderers/background_renderer.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';

void main() {
  group('BackgroundRenderer Tests', () {
    test('should render background color without exceptions', () {
      final config = CanvasVisualConfig(
        backgroundColor: Colors.grey,
        showGrid: false,
      );

      final painter = BackgroundRenderer(config: config);

      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final size = const Size(400, 400);

      expect(() => painter.paint(canvas, size), returnsNormally);
    });

    test('should render grid correctly when enabled', () {
      final config = CanvasVisualConfig(
        backgroundColor: Colors.white,
        gridColor: Colors.blueAccent,
        gridSpacing: 20,
        showGrid: true,
      );

      final painter = BackgroundRenderer(config: config);

      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final size = const Size(400, 400);

      painter.paint(canvas, size);
      final picture = pictureRecorder.endRecording();

      expect(picture, isNotNull);
    });

    test('grid rendering adjusts correctly for offset and scale', () {
      final config = CanvasVisualConfig(
        backgroundColor: Colors.white,
        gridColor: Colors.black12,
        gridSpacing: 50,
        showGrid: true,
      );

      final painter = BackgroundRenderer(
        config: config,
        offset: const Offset(25, 25),
        scale: 2.0,
      );

      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final size = const Size(400, 400);

      painter.paint(canvas, size);
      final picture = pictureRecorder.endRecording();

      expect(picture, isNotNull);
    });

    test('should not render grid when showGrid is false', () {
      final config = CanvasVisualConfig(
        backgroundColor: Colors.white,
        showGrid: false,
      );

      final painter = BackgroundRenderer(config: config);

      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final size = const Size(400, 400);

      painter.paint(canvas, size);
      final picture = pictureRecorder.endRecording();

      expect(picture, isNotNull);
    });

    test('should repaint when configuration changes', () {
      final config1 = CanvasVisualConfig(
        backgroundColor: Colors.white,
        gridSpacing: 20,
        showGrid: true,
      );

      final config2 = CanvasVisualConfig(
        backgroundColor: Colors.white,
        gridSpacing: 40, // 改变 gridSpacing
        showGrid: true,
      );

      final painter1 = BackgroundRenderer(config: config1);
      final painter2 = BackgroundRenderer(config: config2);

      expect(painter2.shouldRepaint(painter1), isTrue);
    });
  });
}
