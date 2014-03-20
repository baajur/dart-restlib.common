part of collections;

// http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/collect/DiscreteDomain.html#minValue()
abstract class DiscreteDomain<T extends Comparable> {
  Option<T> get maxValue;
  Option<T> get minValue;

  bool containsRange(final Range<T> range);

  Option<int> distance(T start, T end);
  Option<T> next(T value);
  Option<T> previous(T value);
}

class IntegerDomain implements DiscreteDomain<int> {
  static const IntegerDomain INT8 = const IntegerDomain._(const Option.constant(-128), const Option.constant(127));
  static const IntegerDomain INT16 = const IntegerDomain._(const Option.constant(-327678), const Option.constant(32767));
  static const IntegerDomain INT32 = const IntegerDomain._(const Option.constant(-2147483648), const Option.constant(2147483647));
  static const IntegerDomain INT64 = const IntegerDomain._(const Option.constant(-9223372036854775808), const Option.constant(9223372036854775807));

  static const IntegerDomain UINT8 = const IntegerDomain._(const Option.constant(0), const Option.constant(255));
  static const IntegerDomain UINT16 = const IntegerDomain._(const Option.constant(0), const Option.constant(65535));
  static const IntegerDomain UINT32 = const IntegerDomain._(const Option.constant(0), const Option.constant(4294967295));
  static const IntegerDomain UINT64 = const IntegerDomain._(const Option.constant(0), const Option.constant(18446744073709551615));

  factory IntegerDomain(int minValue, int maxValue) {
    checkArgument(checkNotNull(minValue) < checkNotNull(maxValue));
    return new IntegerDomain._(new Option(minValue), new Option(maxValue));
  }

  final Option<int> minValue;
  final Option<int> maxValue;

  const IntegerDomain._(this.minValue, this.maxValue);

  bool containsRange(final Range<int> range) {
    final bool max =
        this.maxValue
          .map((final int maxValue) =>
            range.upperBound
              .map((final Bound<int> upperBound) =>
                  upperBound is OpenBound ? maxValue >= upperBound.bound - 1 : maxValue >= upperBound.bound)
              .orElse(false))
          .orElse(true);

    final bool min =
        this.minValue
          .map((final int minValue) =>
              range.lowerBound
                .map((final Bound<int> lowerBound) =>
                    lowerBound is OpenBound ? minValue <= lowerBound.bound + 1 : minValue <= lowerBound.bound)
                .orElse(false))
          .orElse(true);

    return max && min;
  }

  Option<int> distance(int start, int end) {
    checkNotNull(start);
    checkNotNull(end);
    checkArgument(start.compareTo(end) <= 0);
    checkArgument(start >= minValue.value);
    checkArgument(end <= maxValue.value);

    return new Option(end - start);
  }

  Option<int> next(final int value) {
    checkArgument(value <= maxValue.value);
    return value == maxValue.value ? Option.NONE : new Option(value + 1);
  }

  Option<int> previous(int value) {
    checkArgument(value >= minValue.value);
    return value == minValue.value ? Option.NONE : new Option(value - 1);
  }
}

// http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/collect/Range.html
abstract class Range<T extends Comparable> {
  static const Range ALL = const _Range(Option.NONE, Option.NONE);

  factory Range.atLeast(final T value) =>
      new _Range(new Option(new ClosedBound._(checkNotNull(value))), Option.NONE);

  factory Range.atMost(final T value) =>
        new _Range(Option.NONE, new Option(new ClosedBound._(checkNotNull(value))));

  factory Range.closed(final T lower, final T upper) {
    checkNotNull(lower);
    checkNotNull(upper);
    checkArgument(lower.compareTo(upper) <= 0);

    return new _Range(new Option(new ClosedBound._(lower)), new Option(new ClosedBound._(upper)));
  }

  factory Range.closedOpen(final T lower, final T upper) {
    checkNotNull(lower);
    checkNotNull(upper);
    checkArgument(lower.compareTo(upper) <= 0);

    return new _Range(new Option(new ClosedBound._(lower)), new Option(new OpenBound._(upper)));
  }

  factory Range.greaterThan(final T value) =>
      new _Range(new Option(new OpenBound._(checkNotNull(value))), Option.NONE);

  factory Range.lessThan(final T value) =>
      new _Range(Option.NONE, new Option(new OpenBound._(checkNotNull(value))));

  factory Range.open(final T lower, final T upper) {
    checkNotNull(lower);
    checkNotNull(upper);
    checkArgument(lower.compareTo(upper) < 0);

    return new _Range(new Option(new OpenBound._(lower)), new Option(new OpenBound._(upper)));
  }

  factory Range.openClosed(final T lower, final T upper) {
    checkNotNull(lower);
    checkNotNull(upper);
    checkArgument(lower.compareTo(upper) <= 0);

    return new _Range(new Option(new OpenBound._(lower)), new Option(new ClosedBound._(upper)));
  }

  factory Range.single(final T value) =>
      new Range.closed(value, value);

  Option<Bound<T>> get lowerBound;
  Option<Bound<T>> get upperBound;

  bool contains(T value);

  FiniteSet<T> toSet(final DiscreteDomain domain);
}

class _Range<T extends Comparable> implements Range<T> {
  final Option<Bound<T>> lowerBound;
  final Option<Bound<T>> upperBound;

  const _Range (this.lowerBound, this.upperBound);

  bool contains(final T value) {
    bool compareToBound(final Bound bound) =>
        value.compareTo(bound.bound) >= 0;

    checkNotNull(value);
    final bool lower = lowerBound.map(compareToBound).orElse(true);
    final bool upper = upperBound.map(compareToBound).orElse(true);

    return lower && upper;
  }

  FiniteSet<T> toSet(final DiscreteDomain domain) {
    checkNotNull(domain);
    checkArgument(domain.containsRange(this));
    checkArgument(domain.maxValue.isNotEmpty || this.upperBound.isNotEmpty);
    checkArgument(domain.minValue.isNotEmpty || this.lowerBound.isNotEmpty);

    return new _RangeAsSet(this, domain);
  }
}

abstract class Bound<T extends Comparable> {
  T get bound;
}

class ClosedBound<T extends Comparable> implements Bound<T> {
  final T bound;

  const ClosedBound._(this.bound);
}

class OpenBound<T extends Comparable> implements Bound<T> {
  final T bound;

  const OpenBound._(this.bound);
}

class _RangeAsSet<E extends Comparable<E>> extends IterableBase<E> implements FiniteSet<E> {
  final Range<E> range;
  final DiscreteDomain<E> domain;

  const _RangeAsSet(this.range, this.domain);

  Iterable<E> get keys => this;

  Iterator<E> get iterator =>
      new _RangeAsSetIterator(range, domain);

  Iterable<E> get values => this;

  Option<E> operator[](final E key) =>
      range.contains(key) ? new Option(key) : Option.NONE;

  Option<E> call(final E key) =>
      this[E];

  bool contains(E value) =>
      range.contains(value);

  bool containsKey(E key) =>
      this.contains(key);

  bool containsValue(E value) =>
      this.contains(value);

  FiniteSet<E> difference(FiniteSet<E> other) =>
      throw new UnimplementedError();

  FiniteSet<E> intersection(FiniteSet<E> other) =>
      throw new UnimplementedError();

  Associative<E,dynamic> mapValues(mapFunc(E value)) =>
      throw new UnimplementedError();

  FiniteSet<E> union(FiniteSet<E> other) =>
      throw new UnimplementedError();
}

class _RangeAsSetIterator<E extends Comparable> implements Iterator<E> {
  final Range<E> range;
  final DiscreteDomain<E> domain;

  bool started = false;
  E _current = null;

   _RangeAsSetIterator(this.range, this.domain);

  E get current =>
      _current;

  bool moveNext() {
    if (started) {
      return domain.next(current)
          .map((final E next) {
            if(range.contains(next)) {
              _current = next;
              return true;
            }
          }).orCompute(() {
            _current = null;
            return false;
          });
    } else {
      started = true;
      // By definition the range must have a lower bound, otherwise it couldn't be contained in the domain
      final Bound<E> lowerBound = range.lowerBound.value;
      if (lowerBound is ClosedBound) {
        _current = lowerBound.bound;
        return true;
      } else {
        return domain.next(lowerBound.bound)
            .map((final E next) {
              if(range.contains(next)) {
                _current = next;
                return true;
              }
            }).orCompute(() {
              _current = null;
              return false;
            });
      }
    }
  }
}
