part of collections;

class _None extends IterableBase implements None {
  const _None();

  int get hashCode => 0;

  Iterator get iterator => EMPTY_LIST.iterator;

  dynamic get nullableValue => null;

  dynamic get value => throw new StateError("empty");

  bool operator==(final other) =>
      other is None;

  Option flatMap(Option f(element)) => Option.NONE;

  Option map(f(element)) => Option.NONE;

  dynamic orCompute(dynamic call()) => call();

  dynamic orElse(final dynamic alternative) => alternative;

  Option skip(final int n) => Option.NONE;

  Option skipWhile(bool test(value)) => Option.NONE;

  Option take(final int n) => Option.NONE;

  Option takeWhile(bool test(value)) => Option.NONE;

  String toString() => "None";

  Option where(bool f(element)) => Option.NONE;
}

class _Some<E> extends IterableBase<E> implements Some<E> {
  final E value;

  const _Some(this.value);

  E get e0 => value;

  int get hashCode => value.hashCode;

  Iterator get iterator => [value].iterator;

  dynamic get nullableValue => value;

  bool operator==(final other) =>
      other is Some ? other.value == this.value : false;

  Option flatMap(Option f(E element)) => f(value);

  Option map(f(E element)) => new Option(f(value));

  dynamic orCompute(dynamic call()) => value;

  dynamic orElse(final dynamic alternative) => value;

  Option<E> skip(final int n) =>
      (n > 0) ? Option.NONE : this;

  Option<E> skipWhile(bool test(E value)) =>
      test(value) ? Option.NONE : this;

  Option<E> take(final int n) =>
      (n > 0) ? this : Option.NONE;

  Option<E> takeWhile(bool test(E value)) =>
      test(value) ? this : Option.NONE;

  String toString() => "Option($value)";

  Option<E> where(bool f(E element)) =>
      (f(value)) ? this : Option.NONE;
}

class _Pair<T0, T1> extends IterableBase implements Pair<T0, T1> {
  final T0 e0;
  final T1 e1;

  _Pair(this.e0, this.e1);

  int get hashCode =>
      computeHashCode(this);

  bool get isEmpty =>
      false;

  Iterator get iterator =>
      [e0, e1].iterator;

  int get length => 2;

  bool operator==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is Pair) {
      return this.e0 == other.e0 &&
          this.e1 == other.e1;
    } else {
      return false;
    }
  }

  String toString() =>
      "Pair($e0, $e1)";
}

class _Tuple3<T0, T1, T2> extends IterableBase implements Tuple3<T0, T1, T2> {
  final T0 e0;
  final T1 e1;
  final T2 e2;

  _Tuple3(this.e0, this.e1, this.e2);

  int get hashCode =>
      computeHashCode(this);

  Iterator get iterator =>
      [e0, e1, e2].iterator;

  bool operator==(other) =>
      (other is Tuple3) ?  const IterableEquality().equals(this, other) : false;
}

class _Tuple4<T0, T1, T2, T3> extends IterableBase implements Tuple4<T0, T1, T2, T3> {
  final T0 e0;
  final T1 e1;
  final T2 e2;
  final T3 e3;

  _Tuple4(this.e0, this.e1, this.e2, this.e3);

  int get hashCode =>
      computeHashCode(this);

  Iterator get iterator =>
      [e0, e1, e2, e3].iterator;

  bool operator==(other) =>
        (other is Tuple4) ?  const IterableEquality().equals(this, other) : false;
}

class _Tuple5<T0, T1, T2, T3, T4> extends IterableBase implements Tuple5<T0, T1, T2, T3, T4> {
  final T0 e0;
  final T1 e1;
  final T2 e2;
  final T3 e3;
  final T4 e4;

  _Tuple5(this.e0, this.e1, this.e2, this.e3, this.e4);

  int get hashCode =>
      computeHashCode(this);

  Iterator get iterator =>
      [e0, e1, e2, e3, e4].iterator;

  bool operator==(other) =>
        (other is Tuple5) ?  const IterableEquality().equals(this, other) : false;
}

class _Tuple6<T0, T1, T2, T3, T4, T5> extends IterableBase implements Tuple6<T0, T1, T2, T3, T4, T5> {
  final T0 e0;
  final T1 e1;
  final T2 e2;
  final T3 e3;
  final T4 e4;
  final T5 e5;

  _Tuple6(this.e0, this.e1, this.e2, this.e3, this.e4, this.e5);

  int get hashCode =>
      computeHashCode(this);

  Iterator get iterator =>
      [e0, e1, e2, e3, e4, e5].iterator;

  bool operator==(other) =>
        (other is Tuple6) ?  const IterableEquality().equals(this, other) : false;
}

class _TupleRest<T0, T1, T2, T3, T4, T5, TRest extends Tuple> extends IterableBase implements TupleRest<T0, T1, T2, T3, T4, T5, TRest> {
  final T0 e0;
  final T1 e1;
  final T2 e2;
  final T3 e3;
  final T4 e4;
  final T5 e5;
  final TRest rest;

  _TupleRest(this.e0, this.e1, this.e2, this.e3, this.e4, this.e5, this.rest);

  int get hashCode =>
      computeHashCode(this);

  Iterator get iterator =>
      concat([[e0, e1, e2, e3, e4, e5], rest]).iterator;

  bool operator==(other) =>
        (other is TupleRest) ?  const IterableEquality().equals(this, other) : false;
}