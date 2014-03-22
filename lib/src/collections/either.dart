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

abstract class Left<L> implements Either<L,dynamic> {
  Some<L> get left;
  None get right;

  Right<L> swap();
}

abstract class Right<R> implements Either<dynamic, R> {
  None get left;
  Some<R> get right;

  Left<R> swap();
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

class _Left<L> extends _Either<L, dynamic> implements Left<L> {
  final Some<L> left;

  const _Left(this.left);

  None get right => Tuple.NONE;

  dynamic get value => left.e0;

  /*<T>*/ fold(/*<T>*/ onLeft(L left), /*<T>*/ onRight(dynamic right)) =>
      onLeft(left.e0);

  Right<L> swap() =>
      new _Right(left);
}

class _Right<R> extends _Either<dynamic,R> implements Right<R> {
  final Some<R> right;

  const _Right(this.right);

  None get left => Tuple.NONE;

  dynamic get value => right.e0;

  /*<T>*/ fold(/*<T>*/ onLeft(dynamic left), /*<T>*/ onRight(R right)) =>
      onRight(right.e0);

  Left<R> swap() =>
      new _Left(right);
}
