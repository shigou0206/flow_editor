```mermaid
flowchart TD
    A[用户操作<br/>(点击/双击/悬停/右键)]
    B[节点UI组件<br/>(NodeWidget)]
    C[GestureDetector<br/>(NodeGestureHandler)]
    D[单击/双击判断<br/>(定时器逻辑)]
    E[统一交互控制器<br/>(NodeInteractionController)]
    F[业务逻辑<br/>(NodeBehavior)]
    G[执行业务处理<br/>(修改状态、删除等)]
    H[全局协调<br/>(NodeInteractionManager)]
    I[子组件获取控制器<br/>(MouseBehaviorController)]
    J[自定义内部UI响应]

    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    E --> I
    I --> J
    F --> H
```
