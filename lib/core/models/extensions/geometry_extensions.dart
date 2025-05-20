import 'package:flutter/material.dart';

extension SizeExtension on Size {
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
    };
  }
}

extension OffsetExtension on Offset {
  Map<String, dynamic> toJson() {
    return {
      'dx': dx,
      'dy': dy,
    };
  }
}
