part of restlib.common.collections;

abstract class Either<L, R> {
  factory Either.leftValue(final L value) =>
      new _Either(new Option(checkNotNull(value)), Option.NONE);

  factory Either.rightValue(final R value) =>
      new _Either(Option.NONE, new Option(checkNotNull(value)));
  
  Option<L> get left;
  Option<R> get right; 
  dynamic get value;
  
  /*<T>*/ fold(/*<T>*/ leftCase(L left), /*<T>*/ rightCase(R right));
}
  
class _Either<L, R> implements Either<L,R> {
  final Option<L> left;
  final Option<R> right;
  
  _Either(this.left, this.right);
  
  int get hashCode => computeHashCode([left, right]);
  
  dynamic get value =>
      left
        .map((final L left) =>
          left)
        .orCompute(() =>
             right.value); 
  
  /*<T>*/ fold(/*<T>*/ leftCase(L left), /*<T>*/ rightCase(R right)) {      
    return left
      .map((final L left) => 
          leftCase(left))
      .orCompute(() => 
          rightCase(right.value)); 
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
      fold(
          (final L left) => 
              "Either.left($left)", 
          (final R right) =>     
            "Either.right($right)");
}