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
        final routePoints = List<Offset>.from(points);
        
        // 打印路由点信息，帮助调试
        if (debug) {
          debugPrint('边 ${edge.id} 的路由点:');
          for (int i = 0; i < routePoints.length; i++) {
            debugPrint('  点 $i: (${routePoints[i].dx}, ${routePoints[i].dy})');
          }
        }
        
        // 获取源点和目标点（第一个和最后一个路由点）
        final sourcePoint = routePoints.first;
        final targetPoint = routePoints.last;
        
        // 获取倒数第二个点（用于计算箭头角度）
        final secondLastPoint = routePoints.length > 1 
            ? routePoints[routePoints.length - 2] 
            : sourcePoint;
        
        // 计算指向目标节点的方向向量
        final dirX = targetPoint.dx - secondLastPoint.dx;
        final dirY = targetPoint.dy - secondLastPoint.dy;
        final angle = atan2(dirY, dirX);
        
        if (debug) {
          debugPrint('边 ${edge.id} 的角度: ${angle * 180 / pi}°');
        }
        
        // 节点尺寸参数
        const nodeWidth = 100.0;
        const nodeHeight = 60.0;
        
        // 更精确的计算与矩形边界的交点
        double boundaryDistance;
        
        // 根据角度计算与矩形边界的交点
        final absAngle = angle.abs();
        if (absAngle < pi/4 || absAngle > 3*pi/4) {
          // 主要是水平方向（从左或右进入）
          boundaryDistance = nodeWidth / 2;
        } else {
          // 主要是垂直方向（从上或下进入）
          boundaryDistance = nodeHeight / 2;
        }
        
        // 计算边缘交点
        final edgeEndX = targetPoint.dx - boundaryDistance * cos(angle);
        final edgeEndY = targetPoint.dy - boundaryDistance * sin(angle);
        
        // 创建边的路径
        final path = Path();
        path.moveTo(
          sourcePoint.dx + canvasOffset.dx, 
          sourcePoint.dy + canvasOffset.dy
        );
        
        // 绘制所有中间点，使用圆角连接
        final cornerRadius = 15.0; // 转角的圆角半径
        
        if (routePoints.length >= 3) {
          for (var i = 1; i < routePoints.length - 1; i++) {
            final prevPoint = routePoints[i - 1];
            final currentPoint = routePoints[i]; 
            final nextPoint = routePoints[i + 1];
            
            // 计算当前方向向量和下一个方向向量
            final dx1 = currentPoint.dx - prevPoint.dx;
            final dy1 = currentPoint.dy - prevPoint.dy;
            final dx2 = nextPoint.dx - currentPoint.dx;
            final dy2 = nextPoint.dy - currentPoint.dy;
            
            // 如果方向发生了变化，则添加圆角
            if ((dx1 != 0 && dx2 != 0) || (dy1 != 0 && dy2 != 0)) {
              // 计算转角前的点（距离转角cornerRadius的距离）
              final beforeCornerX = currentPoint.dx - dx1 * cornerRadius / sqrt(dx1 * dx1 + dy1 * dy1);
              final beforeCornerY = currentPoint.dy - dy1 * cornerRadius / sqrt(dx1 * dx1 + dy1 * dy1);
              
              // 计算转角后的点（距离转角cornerRadius的距离）
              final afterCornerX = currentPoint.dx + dx2 * cornerRadius / sqrt(dx2 * dx2 + dy2 * dy2);
              final afterCornerY = currentPoint.dy + dy2 * cornerRadius / sqrt(dx2 * dx2 + dy2 * dy2);
              
              // 先画直线到转角前的点
              path.lineTo(
                beforeCornerX + canvasOffset.dx,
                beforeCornerY + canvasOffset.dy
              );
              
              // 再绘制四分之一圆作为转角
              path.quadraticBezierTo(
                currentPoint.dx + canvasOffset.dx,
                currentPoint.dy + canvasOffset.dy,
                afterCornerX + canvasOffset.dx,
                afterCornerY + canvasOffset.dy
              );
            } else {
              // 如果方向没有变化，则直接连接到当前点
              path.lineTo(
                currentPoint.dx + canvasOffset.dx,
                currentPoint.dy + canvasOffset.dy
              );
            }
          }
          
          // 连接到终点前的最后一个点
          final lastPoint = routePoints[routePoints.length - 1];
          path.lineTo(
            lastPoint.dx + canvasOffset.dx,
            lastPoint.dy + canvasOffset.dy
          );
        } else {
          // 如果没有中间点，直接连接到最后一个点
          for (var i = 1; i < routePoints.length; i++) {
            path.lineTo(
              routePoints[i].dx + canvasOffset.dx, 
              routePoints[i].dy + canvasOffset.dy
            );
          }
        }
        
        // 绘制到节点边缘
        path.lineTo(
          edgeEndX + canvasOffset.dx, 
          edgeEndY + canvasOffset.dy
        );
        
        // 绘制边
        if (edge.id == highlightedEdgeId) {
          canvas.drawPath(path, highlightPaint);
        } else {
          canvas.drawPath(path, paint);
        }
        
        // 箭头大小
        const arrowSize = 12.0;
        
        // 箭头尖端位置是边缘交点
        final tipX = edgeEndX + canvasOffset.dx;
        final tipY = edgeEndY + canvasOffset.dy;
        
        // 计算箭头的两个底角
        final x1 = tipX - arrowSize * cos(angle - pi/6);
        final y1 = tipY - arrowSize * sin(angle - pi/6);
        final x2 = tipX - arrowSize * cos(angle + pi/6);
        final y2 = tipY - arrowSize * sin(angle + pi/6);
        
        // 创建并填充箭头路径
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
        
        // 调试辅助 - 绘制关键点
        if (debug) {
          // 绘制边缘交点（绿色）
          canvas.drawCircle(
            Offset(tipX, tipY),
            4.0,
            Paint()..color = Colors.green..style = PaintingStyle.fill
          );
          
          // 绘制目标节点中心点（蓝色）
          canvas.drawCircle(
            Offset(targetPoint.dx + canvasOffset.dx, targetPoint.dy + canvasOffset.dy),
            4.0,
            Paint()..color = Colors.blue..style = PaintingStyle.fill
          );
          
          // 绘制倒数第二个点（红色）- 用于计算方向
          canvas.drawCircle(
            Offset(secondLastPoint.dx + canvasOffset.dx, secondLastPoint.dy + canvasOffset.dy),
            4.0,
            Paint()..color = Colors.red..style = PaintingStyle.fill
          );
          
          // 显示边ID
          final midIdx = routePoints.length ~/ 2;
          final midPoint = routePoints[midIdx];
          final textPainter = TextPainter(
            text: TextSpan(
              text: '${edge.id}\nθ=${(angle * 180 / pi).toStringAsFixed(1)}°',
              style: const TextStyle(color: Colors.red, fontSize: 8),
            ),
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          
          // 绘制文本背景
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
