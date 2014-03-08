part of collections;

Iterable computeIfEmpty(final Iterable itr1, Iterable compute()) =>
    itr1.isNotEmpty ? itr1 : compute();

Option computeIfNotEmpty(final Iterable/*<T>*/ itr, compute(Iterable/*<T>*/)) =>
    itr.isNotEmpty ? new Option(compute(itr)) : Option.NONE;

Iterable/*<T>*/ concat(final Iterable<Iterable> iterables) =>
    iterables.expand((e) => e);


Option/*<T>*/ elementAt(final Iterable/*<T>*/ itr, final int index) {
  try {
    return new Option(itr.elementAt(index));
  } on RangeError {
    return Option.NONE;
  }
}

Option/*<T>*/ first(final Iterable/*<T>*/ itr) {
  try {
    return new Option(itr.first);
  } on StateError {
    return Option.NONE;
  }
}

Option/*<T>*/ firstWhere(final Iterable/*<T>*/ itr, bool test(value)) {
  try {
    return new Option(itr.firstWhere(test));
  } on StateError {
    return Option.NONE;
  }
}

Option/*<T>*/ last(final Iterable/*<T>*/ itr) {
  try {
    return new Option(itr.last);
  } on StateError {
    return Option.NONE;
  }
}

Option/*<T>*/ lastWhere(final Iterable/*<T>*/ itr, bool test(value)) {
  try {
    return new Option(itr.lastWhere(test));
  } on StateError {
    return Option.NONE;
  }
}

Iterable<Tuple> zip(final Iterable<Iterable> itrs) =>
    new _ZippedIterable(itrs);


class _ZippedIterable extends IterableBase<Tuple> {
  final Iterable<Iterable> itrs;

  _ZippedIterable(this.itrs);

  Iterator<Tuple> get iterator =>
      new _ZippedIterator(itrs.map((final Iterable itr) => itr.iterator).toList(growable: false));
}

class _ZippedIterator implements Iterator<Tuple> {
  final Iterable<Iterator> itrs;

  Tuple _current = null;

  _ZippedIterator(this.itrs);

  Tuple get current =>
      _current;

  bool moveNext() {
    if (itrs.every((final Iterator itr) => itr.moveNext())) {
      _current = Tuple.create(itrs.map((final Iterator itr) => itr.current));
      return true;
    } else {
      _current = null;
      return false;
    }
  }
}
