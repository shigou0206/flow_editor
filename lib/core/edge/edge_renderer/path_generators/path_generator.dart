import 'package:flow_editor/core/edge/models/edge_model.dart';
import '../models/edge_path.dart';

abstract class PathGenerator {
  EdgePath? generate(EdgeModel edge);
}
