enum Position {
  left,
  right,
  top,
  bottom,
}

Position revisePosition(Position? position) {
  return switch (position) {
    Position.left => Position.right,
    Position.right => Position.left,
    Position.top => Position.bottom,
    Position.bottom => Position.top,
    null => Position.right,
  };
}
