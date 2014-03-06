part of collections;

Iterable computeIfEmpty(final Iterable itr1, Iterable compute()) =>
    itr1.isNotEmpty ? itr1 : compute();

void computeIfNotEmpty(final Iterable/*<T>*/ itr, void compute(Iterable/*<T>*/)) {
    if (itr.isNotEmpty) {
      compute(itr);
    }
}

Iterable/*<T>*/ concat(final Iterable/*<T>*/ fst, final Iterable/*<T>*/ snd) {
    if (fst.isEmpty) {
      return snd;
    } else if (snd.isEmpty) {
      return fst;
    } else {
      return new _ConcatIterable(fst, snd);
    }
}

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

class _ConcatIterable<T> extends IterableBase<T> {
  final Iterable<T> _fst;
  final Iterable<T> _snd;

  _ConcatIterable(this._fst, this._snd);

  Iterator<T> get iterator => new _ConcatIterator(_fst.iterator, _snd.iterator);
}

class _ConcatIterator<T> implements Iterator<T> {
  final Iterator<T> _fst;
  final Iterator<T> _snd;

  _ConcatIterator(this._fst, this._snd);

  T get current => computeIfNull(_fst.current, () => _snd.current);

  bool moveNext() =>
    _fst.moveNext() ? true : _snd.moveNext();
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
