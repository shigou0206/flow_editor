import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/state_management/theme_provider.dart';
import 'package:flow_editor/ui/canvas/common_editor_canvas.dart';
import 'package:flow_editor/ui/sidebar/nodes_sidebar.dart';
import 'package:flow_editor/ui/property_editor/node_property_editor.dart';
import 'package:flow_editor/ui/property_editor/dsl_editor_widget.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/config/input_config.dart';

final selectedNodeIdProvider = StateProvider<String?>((_) => null);

class CommonEditorPage extends ConsumerStatefulWidget {
  const CommonEditorPage({super.key});

  @override
  ConsumerState<CommonEditorPage> createState() => _CommonEditorPageState();
}

class _CommonEditorPageState extends ConsumerState<CommonEditorPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey canvasKey = GlobalKey();
  late final TabController _tabController;

  double rightSidebarWidth = 320; // 初始宽度
  bool draggingSidebar = false;
  bool hoveringSidebar = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initAndLayoutNodes());
  }

  void _initAndLayoutNodes() {
    final editorNotifier = ref.read(activeEditorNotifierProvider);
    final currentState = ref.read(activeEditorStateProvider);

    editorNotifier.replaceState(
      currentState.copyWith(
        inputConfig: const InputConfig(
          enableEdgeHover: true,
          enableNodeDrag: true,
          enableNodeHover: true,
          enableInsertNodeToEdge: false,
          enableNodeSelect: false,
        ),
      ),
    );
  }

  void handleZoom(double newScale) {
    final canvasBox =
        canvasKey.currentContext?.findRenderObject() as RenderBox?;
    final focalPoint = canvasBox?.size.center(Offset.zero) ?? Offset.zero;
    ref.read(activeCanvasControllerProvider).viewport.zoomAt(focalPoint,
        newScale / ref.read(activeEditorStateProvider).canvasState.scale);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final canvasState = ref.watch(activeEditorStateProvider).canvasState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Editor'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => ref.read(themeModeProvider.notifier).state =
                isDark ? ThemeMode.light : ThemeMode.dark,
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 220,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const FlowNodeSidebar(),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  key: canvasKey,
                  color: Theme.of(context).canvasColor,
                  child: const CommonEditorCanvas(),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: _buildZoomControls(canvasState),
                ),
              ],
            ),
          ),
          _buildResizableSidebar(),
        ],
      ),
    );
  }

  Widget _buildResizableSidebar() {
    return MouseRegion(
      cursor: hoveringSidebar || draggingSidebar
          ? SystemMouseCursors.resizeColumn
          : MouseCursor.defer,
      onHover: (event) {
        final position = event.localPosition.dx;
        setState(() {
          hoveringSidebar = position <= 6; // 靠近左侧边缘6像素内变光标
        });
      },
      onExit: (_) {
        setState(() => hoveringSidebar = false);
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: (details) {
          setState(() => draggingSidebar = true);
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            rightSidebarWidth =
                (rightSidebarWidth - details.delta.dx).clamp(200, 800);
          });
        },
        onHorizontalDragEnd: (_) {
          setState(() => draggingSidebar = false);
        },
        child: Container(
          width: rightSidebarWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              left: BorderSide(
                width: draggingSidebar ? 3 : 1,
                color: draggingSidebar
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: const [
                  Tab(icon: Icon(Icons.settings), text: "节点属性"),
                  Tab(icon: Icon(Icons.code), text: "DSL编辑"),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      NodePropertyEditor(),
                      DslEditorWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomControls(CanvasState canvasState) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => handleZoom(
              (canvasState.scale - 0.1).clamp(0.5, 2.0),
            ),
          ),
          SizedBox(
            width: 120,
            child: Slider(
              value: canvasState.scale,
              min: 0.5,
              max: 2.0,
              onChanged: handleZoom,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => handleZoom(
              (canvasState.scale + 0.1).clamp(0.5, 2.0),
            ),
          ),
        ],
      ),
    );
  }
}
