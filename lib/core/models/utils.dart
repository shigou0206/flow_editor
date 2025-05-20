String createEdgeId(String v, String w, String? name, bool isDirected) {
  if (isDirected || v.compareTo(w) <= 0) {
    return name != null ? '$v\u0001$w\u0001$name' : '$v\u0001$w\u0001\u0000';
  } else {
    return name != null ? '$w\u0001$v\u0001$name' : '$w\u0001$v\u0001\u0000';
  }
}
