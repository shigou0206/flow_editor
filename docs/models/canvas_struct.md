
```mermaid  
flowchart TD
    A[用户输入\n(鼠标/手势/键盘)] --> B[CanvasInteractionManager\n(全局交互管理)]
    B --> C{识别操作类型}
    C -->|平移/缩放| D[更新CanvasState:\n offset/scale]
    C -->|框选| E[更新Selection:\n boxSelection start/end]
    C -->|点击节点区域| F[转发给 NodeInteractionManager]
    C -->|点击边/连线| G[转发给 EdgeInteractionManager]
    D --> H[更新画布渲染\n(CanvasRenderer)]
    E --> H
    F --> H
    G --> H
    H[Canvas重绘] --> I[展示给用户]

    style A fill:#A2D2FF,stroke:#555,stroke-width:1px
    style B fill:#CDB4DB,stroke:#555,stroke-width:1px
    style C fill:#FFF,stroke:#999,stroke-width:1px,stroke-dasharray: 5 5
    style D fill:#FDE2E4,stroke:#555,stroke-width:1px
    style E fill:#FFF,stroke:#999,stroke-width:1px,stroke-dasharray: 5 5
    style F fill:#FFF,stroke:#999,stroke-width:1px,stroke-dasharray: 5 5
    style G fill:#FFF,stroke:#999,stroke-width:1px,stroke-dasharray: 5 5
    style H fill:#BDE0FE,stroke:#555,stroke-width:1px
    style I fill:#FFE5D9,stroke:#555,stroke-width:1px
```
