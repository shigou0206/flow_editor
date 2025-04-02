class SugiyamaConfiguration {
  static const int ORIENTATION_TOP_BOTTOM = 1;
  static const int ORIENTATION_BOTTOM_TOP = 2;
  static const int ORIENTATION_LEFT_RIGHT = 3;
  static const int ORIENTATION_RIGHT_LEFT = 4;

  int orientation = ORIENTATION_TOP_BOTTOM;
  double nodeSeparation = 30;
  double levelSeparation = 50;

  int iterations = 24; // 迭代次数(交叉最小化)
}
