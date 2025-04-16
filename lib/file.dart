import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';

/// =============================================================================
/// 模块1 - 数据模型: ProjectNode
///
/// 用于表示文件夹和文件节点，记录名称、路径、是否目录、展开状态和子节点（懒加载）
/// =============================================================================
class ProjectNode {
  final String name; // 节点名称
  final String path; // 完整路径
  final bool isDirectory; // 是否为目录
  bool isExpanded; // 当前是否展开
  List<ProjectNode>? children; // 子节点，null 表示尚未加载

  ProjectNode({
    required this.name,
    required this.path,
    required this.isDirectory,
    this.isExpanded = false,
    this.children,
  });
}

/// =============================================================================
/// 模块2 - 控制器: TreeController
///
/// 负责管理整个文件树的状态，包括根节点加载、懒加载子节点、排序、以及展开/折叠操作。
/// =============================================================================
class TreeController extends ChangeNotifier {
  List<ProjectNode> roots = [];
  String? rootFolderPath;

  /// 从用户选择的文件夹加载根节点，并按文件夹在前、文件在后、按名称排序
  Future<void> loadFromFolder(String folderPath) async {
    rootFolderPath = folderPath;
    final dir = Directory(folderPath);
    if (await dir.exists()) {
      final entities = await dir.list().toList();
      roots = entities.map((entity) {
        final name = p.basename(entity.path);
        final isDir = FileSystemEntity.isDirectorySync(entity.path);
        return ProjectNode(name: name, path: entity.path, isDirectory: isDir);
      }).toList();
      // 排序：文件夹排前，文件排后，名称按字母顺序排列
      roots.sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      notifyListeners();
    }
  }

  /// 懒加载子节点：当节点未加载时，从真实文件夹中读取内容
  Future<List<ProjectNode>> getChildren(ProjectNode node) async {
    if (node.children != null) return node.children!;
    final dir = Directory(node.path);
    if (await dir.exists()) {
      final entities = await dir.list().toList();
      node.children = entities.map((entity) {
        final name = p.basename(entity.path);
        final isDir = FileSystemEntity.isDirectorySync(entity.path);
        return ProjectNode(name: name, path: entity.path, isDirectory: isDir);
      }).toList();
      // 排序：目录优先，文件其次
      node.children!.sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    } else {
      node.children = [];
    }
    return node.children!;
  }

  /// 切换目录节点的展开或折叠状态，如果需要则进行懒加载操作
  Future<void> toggleNode(ProjectNode node) async {
    if (node.isDirectory) {
      if (!node.isExpanded) {
        await getChildren(node);
      }
      node.isExpanded = !node.isExpanded;
      notifyListeners();
    }
  }
}

/// =============================================================================
/// 模块3 - UI 渲染组件: ProjectTreeNodeWidget
///
/// 递归渲染单个文件/文件夹节点，采用 ListTile 展示，样式类似 VSCode 文件树项。
/// =============================================================================
class ProjectTreeNodeWidget extends StatelessWidget {
  final ProjectNode node;
  final TreeController controller;
  final double indent;

  const ProjectTreeNodeWidget({
    Key? key,
    required this.node,
    required this.controller,
    this.indent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 根据节点类型决定图标：目录使用展开/折叠图标，文件使用文件图标
    final Widget leadingIcon = node.isDirectory
        ? Icon(
            node.isExpanded ? Icons.expand_more : Icons.chevron_right,
            color: Colors.blueAccent,
            size: 20,
          )
        : const Icon(
            Icons.insert_drive_file,
            color: Colors.grey,
            size: 16,
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.transparent,
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
            minLeadingWidth: 0,
            leading: Container(
              width: 24,
              alignment: Alignment.center,
              child: leadingIcon,
            ),
            title: Text(
              node.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            contentPadding: EdgeInsets.only(left: indent + 12, right: 12),
            onTap: () async {
              if (node.isDirectory) {
                await controller.toggleNode(node);
              } else {
                // 模拟打开文件的效果
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('打开文件：${node.path}'),
                    backgroundColor: Colors.grey[800],
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ),
        // 当节点处于展开状态且子节点不为空时，递归渲染子节点
        if (node.isExpanded && node.children != null)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: node.children!
                  .map((child) => ProjectTreeNodeWidget(
                        node: child,
                        controller: controller,
                        indent: indent + 16,
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}

/// =============================================================================
/// 模块4 - 顶层组件: ProjectTreeView
///
/// 监听 TreeController 状态变化，并构建整个文件树的视图列表
/// =============================================================================
class ProjectTreeView extends StatefulWidget {
  final TreeController controller;

  const ProjectTreeView({Key? key, required this.controller}) : super(key: key);

  @override
  _ProjectTreeViewState createState() => _ProjectTreeViewState();
}

class _ProjectTreeViewState extends State<ProjectTreeView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        if (widget.controller.roots.isEmpty) {
          return const Center(
            child: Text(
              '选择一个文件夹',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          );
        }
        return ListView(
          children: widget.controller.roots
              .map((node) => ProjectTreeNodeWidget(
                    node: node,
                    controller: widget.controller,
                  ))
              .toList(),
        );
      },
    );
  }
}

/// =============================================================================
/// 模块5 - 侧边栏容器: SidebarContainer
///
/// 用于包装左侧文件树侧边栏，支持收起和展开效果
/// =============================================================================
class SidebarContainer extends StatelessWidget {
  final TreeController controller;
  final bool isCollapsed;
  final VoidCallback toggleSidebar;
  final String? selectedFolder;

  const SidebarContainer({
    Key? key,
    required this.controller,
    required this.isCollapsed,
    required this.toggleSidebar,
    this.selectedFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 50 : 250,
      color: const Color(0xFF252526),
      child: isCollapsed
          ? Center(
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right,
                    color: Colors.white70),
                onPressed: toggleSidebar,
              ),
            )
          : (selectedFolder == null
              ? const Center(
                  child: Text(
                    '未选择文件夹',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                )
              : ProjectTreeView(controller: controller)),
    );
  }
}

/// =============================================================================
/// 模块6 - 主页面: WorkspaceEditorPage
///
/// 整体页面布局：AppBar + 左侧侧边栏（收起/展开）+ 右侧预留编辑器区域
/// =============================================================================
class WorkspaceEditorPage extends StatefulWidget {
  const WorkspaceEditorPage({Key? key}) : super(key: key);

  @override
  _WorkspaceEditorPageState createState() => _WorkspaceEditorPageState();
}

class _WorkspaceEditorPageState extends State<WorkspaceEditorPage> {
  final TreeController treeController = TreeController();
  String? selectedFolder;
  bool _isSidebarCollapsed = false; // 侧边栏初始展开

  /// 选择本地文件夹，并加载目录结构
  Future<void> chooseFolder() async {
    String? folderPath = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "选择工作区文件夹",
    );
    if (folderPath != null) {
      setState(() {
        selectedFolder = folderPath;
      });
      await treeController.loadFromFolder(folderPath);
    }
  }

  /// 切换侧边栏展开/收起状态
  void toggleSidebar() {
    setState(() {
      _isSidebarCollapsed = !_isSidebarCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工作流项目 - VSCode 风格 Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: '选择文件夹',
            onPressed: chooseFolder,
          ),
          IconButton(
            icon: Icon(
              _isSidebarCollapsed
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left,
            ),
            tooltip: _isSidebarCollapsed ? '展开侧边栏' : '收起侧边栏',
            onPressed: toggleSidebar,
          ),
        ],
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: Row(
        children: [
          SidebarContainer(
            controller: treeController,
            isCollapsed: _isSidebarCollapsed,
            toggleSidebar: toggleSidebar,
            selectedFolder: selectedFolder,
          ),
          const VerticalDivider(
            width: 1,
            color: Color(0xFF3C3C3C),
          ),
          // 右侧编辑器区域预留，可扩展为多标签代码编辑器或自研 FlowEditor
          const Expanded(
            child: Center(
              child: Text(
                '编辑器区域（预留）',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1E1E1E),
    );
  }
}

/// =============================================================================
/// 模块7 - 主函数入口
/// =============================================================================
void main() {
  runApp(const MyApp());
}

/// 应用入口 Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VSCode-like File Explorer Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        primaryColor: const Color(0xFF007ACC),
        // 如果是 Material 3，请使用 bodyMedium 替换 bodyText2
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      home: const WorkspaceEditorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
