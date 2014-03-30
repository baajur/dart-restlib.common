library io;

import "dart:async";

import "collections.dart";
import "objects.dart";
import "preconditions.dart";

part "src/io/limit_stream.dart";

abstract class ByteStreamable {
  factory ByteStreamable.byteRange(final ByteRangeable delegate, [final int start, final int end]) =>
      new _ByteRange(delegate, firstNotNull(start, 0), new Option(end));
  Stream<List<int>> asByteStream();
}

abstract class ByteRangeable {
  Future<int> length();
  Stream<List<int>> openRead([int start, int end]);
}

class _ByteRange implements ByteStreamable {
  final ByteRangeable delegate;
  final int start;
  final Option<int> end;

  _ByteRange(this.delegate, this.start, this.end) {
    checkNotNull(start);
  }

  Stream<List<int>> asByteStream() =>
      delegate.openRead(start, end.nullableValue);
}