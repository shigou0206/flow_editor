// ===================== 基础枚举类型 ===================== //
enum EdgeLineCap { butt, round, square }

enum EdgeLineJoin { miter, round, bevel }

enum ArrowType { none, triangle, diamond, arrow, normal }

enum EdgeMode {
  line,
  orthogonal3,
  orthogonal5,
  bezier,
  hvBezier, // "horizontal/vertical" strict
}

enum OverlayDirection {
  above,
  below,
  left,
  right,
}
