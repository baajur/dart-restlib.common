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

  dynamic orCompute(dynamic call()) => call;

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