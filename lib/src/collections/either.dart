part of restlib.common.collections;

class Either<L, R> {
  final Option<L> left;
  final Option<R> right;  
  
  Either.leftValue(final L value):
    left = new Option(checkNotNull(value)),
    right = Option.NONE;

  Either.rightValue(final R value):
    left = Option.NONE,
    right = new Option(checkNotNull(value));
  
  int get hashCode => computeHashCode([left, right]);
  
  /*<T>*/ fold(/*<T>*/ leftCase(L left), /*<T>*/ rightCase(R right)) {
    checkNotNull(leftCase);
    checkNotNull(rightCase);
      
    return left
      .map((final L left) => leftCase(left))
      .orCompute(() => rightCase(right.value)); 
  }

  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Either) {
      return this.left == other.left &&
          this.right == other.right;
    } else {
      return false;
    }
  }
  
  String toString() =>
      left
        .map((final L left) => "Either.left($left)")
        .orElse("Either.right(${right.value}");
}