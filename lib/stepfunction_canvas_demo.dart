import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: CanvasDemo()));
  }
}

class Node {
  String id;
  Offset position;

  Node({required this.id, required this.position});
}

class Edge {
  String id;
  String sourceId;
  String targetId;

  Edge({required this.id, required this.sourceId, required this.targetId});
}

final nodeProvider = StateProvider<List<Node>>((ref) => [
      Node(id: 'start', position: Offset(150, 100)),
      Node(id: 'end', position: Offset(150, 400)),
      Node(id: 'task1', position: Offset(150, 200)),
      Node(id: 'task2', position: Offset(150, 300)),
    ]);

final edgeProvider = StateProvider<List<Edge>>((ref) => [
      Edge(id: 'start-end', sourceId: 'start', targetId: 'end'),
      Edge(id: 'start-task1', sourceId: 'start', targetId: 'task1'),
      Edge(id: 'task1-end', sourceId: 'task1', targetId: 'end'),
    ]);

class CanvasDemo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = ref.watch(nodeProvider);
    final edges = ref.watch(edgeProvider);

    return Stack(children: [
      CustomPaint(
        size: Size.infinite,
        painter: EdgePainter(nodes: nodes, edges: edges),
      ),
      ...nodes.map((node) => Positioned(
            left: node.position.dx - 25,
            top: node.position.dy - 25,
            child: Draggable<Node>(
              data: node,
              feedback: NodeWidget(node),
              childWhenDragging: Opacity(opacity: 0.3, child: NodeWidget(node)),
              child: NodeWidget(node),
            ),
          )),
      Positioned.fill(
        child: DragTarget<Node>(
          onAcceptWithDetails: (details) {
            final position = details.offset;
            final edge = edges.first;

            final newNode = Node(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                position: position);

            // Update nodes
            ref
                .read(nodeProvider.notifier)
                .update((state) => [...state, newNode]);

            // Replace existing edge with two new edges
            ref.read(edgeProvider.notifier).update((state) => [
                  ...state.where((e) => e.id != edge.id),
                  Edge(
                      id: '${edge.sourceId}-${newNode.id}',
                      sourceId: edge.sourceId,
                      targetId: newNode.id),
                  Edge(
                      id: '${newNode.id}-${edge.targetId}',
                      sourceId: newNode.id,
                      targetId: edge.targetId),
                ]);
          },
          builder: (context, candidateData, rejectedData) => Container(),
        ),
      ),
      Positioned(
        right: 20,
        bottom: 20,
        child: ElevatedButton(
          child: Text('Reset'),
          onPressed: () {
            ref.read(nodeProvider.notifier).state = [
              Node(id: 'start', position: Offset(150, 100)),
              Node(id: 'end', position: Offset(150, 400)),
            ];
            ref.read(edgeProvider.notifier).state = [
              Edge(id: 'start-end', sourceId: 'start', targetId: 'end'),
            ];
          },
        ),
      ),
    ]);
  }
}

class NodeWidget extends StatelessWidget {
  final Node node;
  const NodeWidget(this.node);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.grey)],
      ),
      child: Text(node.id),
    );
  }
}

class EdgePainter extends CustomPainter {
  final List<Node> nodes;
  final List<Edge> edges;

  EdgePainter({required this.nodes, required this.edges});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (final edge in edges) {
      final source = nodes.firstWhere((n) => n.id == edge.sourceId);
      final target = nodes.firstWhere((n) => n.id == edge.targetId);
      canvas.drawLine(source.position, target.position, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
