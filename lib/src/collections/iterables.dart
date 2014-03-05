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

bool equal(final Iterable fst, final Iterable snd) {
  final Iterator itrFst = fst.iterator;
  final Iterator itrSnd = snd.iterator;
  
  bool fstMoveNext = itrFst.moveNext();
  bool sndMoveNext = itrSnd.moveNext();
  
  for (;fstMoveNext && sndMoveNext; 
      fstMoveNext = itrFst.moveNext(), sndMoveNext = itrSnd.moveNext()) {
    if(itrFst.current != itrSnd.current) {
      return false;
    }
  }
  
  return fstMoveNext == sndMoveNext;
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

Iterable<Pair/*<T1,T2>*/> zip(final Iterable/*<T1>*/ fst, final Iterable/*<T2>*/ snd) =>
    new _ZippedIterable(fst, snd);

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
  
  T get current => firstNotNull(_fst.current, _snd.current);
  
  bool moveNext() =>
    _fst.moveNext() ? true : _snd.moveNext();
}

class _ZippedIterable<T1,T2> extends IterableBase<Pair<T1,T2>> {
  final Iterable<T1> _fst;
  final Iterable<T2> _snd;
  
  _ZippedIterable(this._fst, this._snd);
  
  Iterator<Pair<T1,T2>> get iterator =>
      new _ZippedIterator(_fst.iterator, _snd.iterator);
}

class _ZippedIterator<T1,T2> implements Iterator<Pair<T1, T2>> {
  final Iterator<T1> _fst;
  final Iterator<T2> _snd;
  
  Pair<T1, T2> _current = null;
  
  _ZippedIterator(this._fst, this._snd);
    
  Pair<T1, T2> get current =>
      _current;
    
  bool moveNext() {
    if (_fst.moveNext() && _snd.moveNext()) {
      _current = new Pair(_fst.current, _snd.current);
      return true;
    } else {
      _current = null;
      return false;
    } 
  }
}
