enum DragMode { full, handle }

enum NodeRole { placeholder, start, middle, end, custom }

enum NodeStatus {
  none,
  running,
  completed,
  cancelled,
  failed,
  pending,
  orphaned,
  unlinked,
  normal
}
