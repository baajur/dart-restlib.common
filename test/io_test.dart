library io_test;

import "dart:async";
import "package:restlib_common/io.dart";

void main() {
  final Stream<List<int>> stream = new Stream.fromIterable([[1,2,3], [4,5,6], [7,8,9] ]);

  final LimitStream limit = new LimitStream(stream, 5);
  limit.forEach((final List<int> bytes) => print("limit: $bytes"));
  limit.remainder.forEach((final List<int> bytes) => print("remainder: $bytes"));
}