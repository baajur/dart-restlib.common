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

abstract class IndexedIterator<T> implements BidirectionalIterator<T> {
  factory IndexedIterator.list(final List<T> list) =>
      new _ListIterator(checkNotNull(list));

  int get index;
  void set index(final int index);
}

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

class _ListIterator<T> implements IndexedIterator<T> {
  int _current = null;
  int _index = -1;

  final List<T> list;

  _ListIterator(this.list);

  int get current =>
      computeIfNull(_current, () =>
          throw new StateError("Index is out of bounds"));

  int get index => _index;

  void set index(final int index) {
    checkRangeInclusive(-1, list.length, index);
    _index = index;
  }

  void _updateCurrent() {
    if(index == -1 || index == list.length) {
      this._current = null;
    } else {
      this._current = list[index];
    }
  }

  bool moveNext() {
    if (index < list.length) {
      _index++;
      _updateCurrent();
      return !(index == list.length);
    } else {
      return false;
    }
  }

  bool movePrevious() {
    if (index > -1) {
      index--;
      _updateCurrent();
      return !(index == -1);
    } else {
      return false;
    }
  }
}