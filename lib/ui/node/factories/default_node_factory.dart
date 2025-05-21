// lib/ui/node/factories/default_node_factory.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/models/styles/node_style.dart';

/// 一个默认的 NodeWidgetFactory，实现最基础的样式渲染。
class DefaultNodeFactory implements NodeWidgetFactory {
  const DefaultNodeFactory();

  @override
  Widget createNodeWidget(NodeModel node) {
    final style = node.style ?? const NodeStyle();

    // 将 Hex 颜色字符串转换为 Flutter 的 Color
    Color _parseHex(String? hex, Color fallback) {
      if (hex == null) return fallback;
      final cleaned = hex.replaceFirst('#', '');
      final value = int.tryParse(cleaned, radix: 16);
      if (value == null) return fallback;
      // 如果只提供了 RRGGBB，则加上 FF 前缀
      final argb = cleaned.length == 6 ? 0xFF000000 | value : value;
      return Color(argb);
    }

    return Container(
      width: node.size.width,
      height: node.size.height,
      decoration: BoxDecoration(
        color: _parseHex(style.fillColorHex, Colors.white),
        border: Border.all(
          color: _parseHex(style.borderColorHex, Colors.black),
          width: style.borderWidth,
        ),
        borderRadius: BorderRadius.circular(style.borderRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        node.title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _parseHex(style.borderColorHex, Colors.black),
        ),
      ),
    );
  }
}
