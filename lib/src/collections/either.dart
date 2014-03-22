part of collections;

abstract class Either<L, R> {
  factory Either.leftValue(final L value) =>
      new _Left(Tuple.create1(value));

  factory Either.rightValue(final R value) =>
      new _Right(Tuple.create1(value));

  const factory Either.leftConstant(final Some<L> value) = _Left;
  const factory Either.rightConstant(final Some<R> value) = _Right;

  Option<L> get left;
  Option<R> get right;
  dynamic get value;

  /*<T>*/ fold(/*<T>*/ onLeft(L left), /*<T>*/ onRight(R right));
}

abstract class _Either<L,R> implements Either<L,R> {
  const _Either();

  int get hashCode => computeHashCode([left, right]);

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
        fold((final L left) => "Either.left($left)",
             (final R right) => "Either.right($right)");
}

class _Left<L,R> extends _Either<L,R> {
  final Some<L> left;

  const _Left(this.left);

  Option<R> get right =>
      Option.NONE;

  dynamic get value => left.e0;

  /*<T>*/ fold(/*<T>*/ onLeft(L left), /*<T>*/ onRight(R right)) =>
      onLeft(left.e0);
}

class _Right<L,R> extends _Either<L,R> {
  final Some<R> right;

  const _Right(this.right);

  Option<L> get left =>
      Option.NONE;

  dynamic get value => right.e0;

  /*<T>*/ fold(/*<T>*/ onLeft(L left), /*<T>*/ onRight(R right)) =>
      onRight(right.e0);
}
