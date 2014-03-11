part of collections;

abstract class Option<E> implements Tuple<E> {
  static const None NONE = const _None();

  factory Option(final E value) =>
        value == null ? Option.NONE : new _Some(value);

  const factory Option.constant(final E value) = _Some;

  E get nullableValue;

  E get value;

  Option flatMap(Option f(E element));

  Option map(f(E element));

  dynamic orCompute(dynamic call());

  dynamic orElse(final dynamic alternative);

  Option<E> skip(final int n);

  Option<E> skipWhile(bool test(E value));

  Option<E> takeWhile(bool test(E value));

  Option<E> where(bool f(E element));
}