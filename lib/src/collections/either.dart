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
  Either<R, L> swap();
}

abstract class Left<L,R> implements Either<L,R> {
  Some<L> get left;
  None get right;
  L get value;

  Right<R,L> swap();
}

abstract class Right<L,R> implements Either<L,R> {
  None get left;
  Some<R> get right;
  R get value;

  Left<R,L> swap();
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

class _Left<L,R> extends _Either<L, R> implements Left<L,R> {
  final Some<L> left;

  const _Left(this.left);

  None get right => Tuple.NONE;

  L get value => left.e0;

  /*<T>*/ fold(/*<T>*/ onLeft(L left), /*<T>*/ onRight(R right)) =>
      onLeft(left.e0);

  Right<R,L> swap() =>
      new _Right(left);
}

class _Right<L,R> extends _Either<L,R> implements Right<L,R> {
  final Some<R> right;

  const _Right(this.right);

  None get left => Tuple.NONE;

  R get value => right.e0;

  /*<T>*/ fold(/*<T>*/ onLeft(dynamic left), /*<T>*/ onRight(R right)) =>
      onRight(right.e0);

  Left<R,L> swap() =>
      new _Left(right);
}
