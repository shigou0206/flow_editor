// import 'package:flutter_test/flutter_test.dart';
// import 'package:flow_editor/core/state_management/canvas_state/canvas_state_provider.dart';
// import 'package:flow_editor/core/canvas/models/canvas_interaction_mode.dart';

// void main() {
//   group('MultiCanvasStateNotifier - Comprehensive Tests', () {
//     late MultiCanvasStateNotifier notifier;

//     setUp(() {
//       // 默认构造：activeWorkflowId='default'
//       notifier = MultiCanvasStateNotifier();
//     });

//     group('Initial State', () {
//       test('默认workflow应为 "default"', () {
//         expect(notifier.state.activeWorkflowId, 'default');
//         expect(notifier.state.workflows.keys, contains('default'));
//       });

//       test('默认canvasState应为初始值', () {
//         final canvas = notifier.state.activeState;
//         expect(canvas.offset, Offset.zero);
//         expect(canvas.scale, 1.0);
//         expect(canvas.mode, CanvasInteractionMode.panCanvas);
//         // 确保默认 showGrid, minScale, maxScale 符合你项目的设计
//         expect(canvas.visualConfig.showGrid, false);
//         expect(canvas.interactionConfig.minScale, 0.1);
//         expect(canvas.interactionConfig.maxScale, 10.0);
//       });
//     });

//     group('Canvas Offset & Scale', () {
//       test('panBy 应正确更新 offset', () {
//         notifier.panBy(50, -20);
//         expect(notifier.state.activeState.offset, const Offset(50, -20));
//       });

//       test('setOffset 应正确设置绝对位置', () {
//         notifier.setOffset(const Offset(200, 100));
//         expect(notifier.state.activeState.offset, const Offset(200, 100));
//       });

//       test('setScale 应正确设置缩放', () {
//         notifier.setScale(2.5);
//         expect(notifier.state.activeState.scale, 2.5);
//       });

//       test('setScale 超出范围时应 clamp', () {
//         // 若默认 interactionConfig.minScale=0.1, maxScale=4.0(假设)
//         // 如果你保留 0.1~10.0, 也行

//         // 先设个极大值
//         notifier.setScale(100);
//         expect(notifier.state.activeState.scale, 10.0, // or 4.0
//             reason: 'Should clamp to maxScale');

//         // 再设极小值
//         notifier.setScale(0.01);
//         expect(notifier.state.activeState.scale, 0.1,
//             reason: 'Should clamp to minScale');
//       });

//       test('zoomAtPoint 应正确处理缩放及偏移', () {
//         // 初始 scale=1, offset=(0,0)
//         // zoom x2 at (100,100) => newScale=2.0
//         // offset => (0-100)*2 +100= -200+100= -100
//         notifier.zoomAtPoint(2.0, const Offset(100, 100));

//         expect(notifier.state.activeState.scale, 2.0);
//         expect(notifier.state.activeState.offset, const Offset(-100, -100));
//       });
//     });

//     group('Interaction Mode', () {
//       test('setInteractionMode 应切换模式', () {
//         notifier.setInteractionMode(CanvasInteractionMode.multiSelect);
//         expect(
//             notifier.state.activeState.mode, CanvasInteractionMode.multiSelect);

//         notifier.setInteractionMode(CanvasInteractionMode.editNode);
//         expect(notifier.state.activeState.mode, CanvasInteractionMode.editNode);
//       });
//     });

//     group('Visual & Interaction Config', () {
//       test('toggleGrid 可切换网格可见性', () {
//         final initial = notifier.state.activeState.visualConfig.showGrid;
//         notifier.toggleGrid();
//         final updated = notifier.state.activeState.visualConfig.showGrid;

//         expect(updated, !initial,
//             reason: 'showGrid should toggle from $initial to $updated');
//       });

//       test('updateVisualConfig 可灵活更新 visualConfig', () {
//         notifier.updateVisualConfig((vc) => vc.copyWith(showGrid: true));
//         expect(notifier.state.activeState.visualConfig.showGrid, true);

//         notifier.updateVisualConfig((vc) => vc.copyWith(showGrid: false));
//         expect(notifier.state.activeState.visualConfig.showGrid, false);
//       });

//       test('updateInteractionConfig 可修改 minScale / maxScale / allowPan等', () {
//         notifier.updateInteractionConfig((cfg) =>
//             cfg.copyWith(minScale: 0.5, maxScale: 3.0, allowPan: false));

//         final updated = notifier.state.activeState.interactionConfig;
//         expect(updated.minScale, 0.5);
//         expect(updated.maxScale, 3.0);
//         expect(updated.allowPan, false);
//       });
//     });

//     group('resetCanvas', () {
//       test('resetCanvas 应重置为默认状态(但保留 interactionConfig)', () {
//         // 先修改
//         notifier.setScale(3.0);
//         notifier.setOffset(const Offset(80, 90));
//         notifier.setInteractionMode(CanvasInteractionMode.editNode);

//         final oldConfig = notifier.state.activeState.interactionConfig;

//         notifier.resetCanvas();

//         final resetState = notifier.state.activeState;
//         expect(resetState.offset, Offset.zero);
//         expect(resetState.scale, 1.0);
//         expect(resetState.mode, CanvasInteractionMode.panCanvas);
//         // 但 interactionConfig 不变
//         expect(resetState.interactionConfig, oldConfig);
//       });
//     });

//     group('多workflow支持', () {
//       test('切换到不存在workflow自动创建', () {
//         notifier.switchWorkflow('workflow-2');
//         expect(notifier.state.activeWorkflowId, 'workflow-2');
//         expect(notifier.state.workflows.containsKey('workflow-2'), true);
//         // 新建的 offset=0,0 scale=1.0 ...
//         expect(notifier.state.activeState.offset, Offset.zero);
//       });

//       test('不同workflow状态彼此独立', () {
//         notifier.switchWorkflow('flowA');
//         notifier.setOffset(const Offset(100, 100));

//         notifier.switchWorkflow('flowB');
//         notifier.setOffset(const Offset(200, 200));

//         notifier.switchWorkflow('flowA');
//         expect(notifier.state.activeState.offset, const Offset(100, 100),
//             reason: 'flowA offset should persist');

//         notifier.switchWorkflow('flowB');
//         expect(notifier.state.activeState.offset, const Offset(200, 200),
//             reason: 'flowB offset should persist');
//       });

//       test('新建workflow继承当前interactionConfig', () {
//         // 先更改 default 的 interactionConfig
//         notifier.updateInteractionConfig((cfg) => cfg.copyWith(maxScale: 3.0));
//         final oldConfig = notifier.state.activeState.interactionConfig;

//         // 切换到 workflowX => auto create
//         notifier.switchWorkflow('workflowX');
//         // 验证 workflowX 用的是 oldConfig
//         expect(notifier.state.activeState.interactionConfig, oldConfig);
//       });

//       test('removeWorkflow只可移除非激活的workflow', () {
//         notifier.switchWorkflow('workflowA');
//         expect(notifier.state.activeWorkflowId, 'workflowA');

//         // 尝试移除 'workflowA'，应无效（因其是当前激活的）
//         notifier.removeWorkflow('workflowA');
//         expect(notifier.state.workflows.containsKey('workflowA'), isTrue,
//             reason: '仍然存在，因为它是激活的');

//         // 切换回 default，然后删除 workflowA
//         notifier.switchWorkflow('default');
//         notifier.removeWorkflow('workflowA');
//         expect(notifier.state.workflows.containsKey('workflowA'), isFalse);
//       });
//     });
//   });
// }
