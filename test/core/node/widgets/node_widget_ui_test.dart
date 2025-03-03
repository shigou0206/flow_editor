import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';

void main() {
  testWidgets('NodeWidget visual UI test', (WidgetTester tester) async {
    final node = NodeModel(
      id: 'node-1',
      x: 50,
      y: 100,
      width: 200,
      height: 100,
      type: 'default',
      title: 'Visual Node',
      anchors: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: Stack(
                children: [
                  NodeWidget(
                    node: node,
                    child: Container(
                      width: node.width,
                      height: node.height,
                      color: Colors.blueAccent,
                      alignment: Alignment.center,
                      child: const Text(
                        'Visual Test Node',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // 生成并与黄金文件(golden file)进行视觉对比
    await expectLater(
      find.byType(NodeWidget),
      matchesGoldenFile('node_widget_ui_test.png'),
    );
  });
}
