class Node {
  final int id;
  double x;
  double y;
  double width;
  double height;

  Node({
    required this.id,
    this.x = 0.0,
    this.y = 0.0,
    this.width = 40.0,
    this.height = 40.0,
  });

  @override
  String toString() => 'Node($id, x=$x, y=$y, w=$width, h=$height)';
}
