
```mermaid
flowchart TD
    A[用户操作<br/>(点击/悬停/右键/拖拽端点)]
    B[画布或 Edge区域<br/>(EdgePainter/可点击区域)]
    C[GestureDetector/CanvasInteractionManager<br/>(处理PointerDown/Move/Up)]
    D[事件区分<br/>(点击/双击/拖拽端点/右键)]
    E[统一交互控制器<br/>(EdgeInteractionController)]
    F[业务逻辑<br/>(EdgeBehavior)]
    G[更新Edge状态<br/>(EdgeState或EdgeModel)]
    H[全局协调<br/>(EdgeInteractionManager)]
    I[渲染层<br/>(EdgeRenderer)]
    J[自定义内部响应<br/>(EdgePluginManager/自定义逻辑)]

    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    E --> I
    F --> H
    F --> J
```
