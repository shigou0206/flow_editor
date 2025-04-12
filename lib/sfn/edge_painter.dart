import 'package:flutter/material.dart';
import 'models.dart';
import 'dart:math';

class EdgePainter extends CustomPainter {
  final List<EdgeModel> edges;
  final Map<String, List<Offset>> routes;
  final Offset canvasOffset;
  final bool debug;
  final String? highlightedEdgeId;

  EdgePainter({
    required this.edges,
    required this.routes,
    required this.canvasOffset,
    this.debug = false,
    this.highlightedEdgeId,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (debug) {
      debugPrint('EdgePainter: 开始绘制 ${edges.length} 条边');
      debugPrint('EdgePainter: 画布偏移量: $canvasOffset');
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final highlightPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final arrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final arrowHighlightPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (final edge in edges) {
      final points = routes[edge.id];
      if (points != null && points.length >= 2) {
        // 处理原始路由点
        final originalPoints = List<Offset>.from(points);
        
        // 获取源点和目标点
        final sourcePoint = originalPoints.first;
        final targetPoint = originalPoints.last;
        
        // 获取倒数第二个点（用于计算箭头角度）
        final secondLastPoint = originalPoints.length > 2 
            ? originalPoints[originalPoints.length - 2] 
            : originalPoints.first;
        
        // 计算方向向量和角度
        final dx = targetPoint.dx - secondLastPoint.dx;
        final dy = targetPoint.dy - secondLastPoint.dy;
        final angle = atan2(dy, dx);
        
        // 节点尺寸参数 - 基于 NodeModel 的 width 和 height
        final nodeWidth = 100.0;
        final nodeHeight = 60.0;
        
        // 计算节点边界到中心的距离（根据从哪个方向进入节点）
        double boundaryDistance;
        
        // 根据角度确定是从哪个方向进入节点（上下左右）
        final absAngle = angle.abs();
        if (absAngle <= pi/4 || absAngle >= 3*pi/4) {
          // 从左右方向进入
          boundaryDistance = nodeWidth / 2;
        } else {
          // 从上下方向进入
          boundaryDistance = nodeHeight / 2;
        }
        
        // 计算箭头应该在的位置（节点边界）
        final edgeEndX = targetPoint.dx - boundaryDistance * cos(angle);
        final edgeEndY = targetPoint.dy - boundaryDistance * sin(angle);
        
        // 创建边的路径
        final path = Path();
        path.moveTo(sourcePoint.dx + canvasOffset.dx, sourcePoint.dy + canvasOffset.dy);
        
        // 绘制所有中间点
        for (var i = 1; i < originalPoints.length - 1; i++) {
          path.lineTo(originalPoints[i].dx + canvasOffset.dx, originalPoints[i].dy + canvasOffset.dy);
        }
        
        // 绘制到边缘点
        path.lineTo(edgeEndX + canvasOffset.dx, edgeEndY + canvasOffset.dy);
        
        // 绘制边
        if (edge.id == highlightedEdgeId) {
          canvas.drawPath(path, highlightPaint);
        } else {
          canvas.drawPath(path, paint);
        }
        
        // 绘制箭头 - 直接在边缘点上添加
        const arrowSize = 10.0; // 稍微增大箭头尺寸，使其更明显
        final tipX = edgeEndX + canvasOffset.dx;
        final tipY = edgeEndY + canvasOffset.dy;
        
        // 计算箭头底边两个点
        final x1 = tipX - arrowSize * cos(angle - pi / 6);
        final y1 = tipY - arrowSize * sin(angle - pi / 6);
        final x2 = tipX - arrowSize * cos(angle + pi / 6);
        final y2 = tipY - arrowSize * sin(angle + pi / 6);
        
        // 创建箭头路径
        final arrowPath = Path();
        arrowPath.moveTo(tipX, tipY);
        arrowPath.lineTo(x1, y1);
        arrowPath.lineTo(x2, y2);
        arrowPath.close();
        
        // 绘制箭头
        if (edge.id == highlightedEdgeId) {
          canvas.drawPath(arrowPath, arrowHighlightPaint);
        } else {
          canvas.drawPath(arrowPath, arrowPaint);
        }
        
        // 绘制端点指示 - 帮助调试
        if (debug) {
          // 在箭头尖端绘制小圆点
          canvas.drawCircle(
            Offset(tipX, tipY),
            3.0,
            Paint()..color = Colors.green..style = PaintingStyle.fill
          );
          
          // 在直线中间点绘制边的ID
          final midPoint = originalPoints[originalPoints.length ~/ 2];
          final textPainter = TextPainter(
            text: TextSpan(
              text: edge.id,
              style: const TextStyle(color: Colors.red, fontSize: 8),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          
          // 在中点绘制文本背景
          canvas.drawRect(
            Rect.fromLTWH(
              midPoint.dx + canvasOffset.dx - 2,
              midPoint.dy + canvasOffset.dy - 2,
              textPainter.width + 4,
              textPainter.height + 4
            ),
            Paint()..color = Colors.white..style = PaintingStyle.fill
          );
          
          // 绘制文本
          textPainter.paint(
            canvas, 
            Offset(
              midPoint.dx + canvasOffset.dx,
              midPoint.dy + canvasOffset.dy
            )
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(EdgePainter oldDelegate) {
    return edges != oldDelegate.edges ||
        routes != oldDelegate.routes ||
        canvasOffset != oldDelegate.canvasOffset ||
        debug != oldDelegate.debug ||
        highlightedEdgeId != oldDelegate.highlightedEdgeId;
  }
}
