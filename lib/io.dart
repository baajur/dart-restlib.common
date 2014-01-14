library restlib.common.io;

import "dart:async";

import "collections.dart";
import "objects.dart";
import "preconditions.dart";

abstract class ByteStreamable {      
  Stream<List<int>> asByteStream();
}

abstract class ByteRange implements ByteStreamable {
  factory ByteRange(final ByteSubRangeable delegate, [final int start, final int end]) =>
      new _ByteSubRange(delegate, firstNotNull(start, 0), new Option(end));
  
  Future<int> length();
  ByteRange subRange(int start, int end);
}

abstract class ByteSubRangeable {  
  Future<int> length();
  Stream<List<int>> openRead([int start, int end]);
}

class _ByteSubRange implements ByteRange, ByteSubRangeable {
  final ByteSubRangeable delegate;
  final int start;
  final Option<int> end;
  
  _ByteSubRange(this.delegate, this.start, this.end) {
    checkNotNull(start);
  }
  
  Stream<List<int>> openRead([int start, int end]) {
    start = firstNotNull(start, 0);
    checkArgument(start >= 0);
    
    Option<int> endOption = 
        new Option(end)
          .orElse(this.end.map((final int end) =>
              end - this.start));
    
    endOption.map((final int end) => 
        checkArgument(end >= 0));
    
    final int newStart = this.start + start;
    final Option<int> newEnd = 
        endOption.map((final int end) =>
            this.start + end);
    newEnd.map((final int end) {
      checkArgument(newStart <= end);
      this.end.map((final int oldEnd) => 
          checkArgument(end <= oldEnd));
    });

    
    return delegate.openRead(newStart, newEnd.nullableValue);
  }
  
  Future<int> length() =>
      end
        .map((final int end) => 
            new Future.value(end - start))
        .orCompute(() => 
            delegate.length()
              .then((final int length) =>
                  length - start));
  
  ByteRange subRange(final int start, final int end) {
    checkArgument(start >= 0);
    checkArgument(end >= 0);
    
    final int newStart = this.start + start;
    final int newEnd = this.start + end;
    
    checkArgument(newStart <= newEnd);
    this.end.map((final int end) =>
        checkArgument(newEnd <= end));
    
    return new ByteRange(delegate, newStart, newEnd);
  }
  
  Stream<List<int>> asByteStream() =>
      openRead();
}