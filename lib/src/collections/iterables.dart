part of common.collections;

Iterable/*<T>*/ concat(final Iterable/*<T>*/ fst, final Iterable/*<T>*/ snd) => 
    new _ConcatIterable(fst, snd);

Option/*<T>*/ elementAt(final Iterable/*<T>*/ itr, final int index) {
  try {
    return new Option(itr.elementAt(index));
  } on RangeError {
    return Option.NONE;
  }
}

bool equal(final Iterable fst, final Iterable snd) {
  final Iterator itrFst = checkNotNull(fst).iterator;
  final Iterator itrSnd = checkNotNull(snd).iterator;
  
  while(itrFst.moveNext() && itrSnd.moveNext()) {
    if(itrFst.current != itrSnd.current) {
      return false;
    }
  }
  
  return !(itrFst.moveNext() || itrSnd.moveNext());
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

Iterable<Pair<Option/*<T1>*/, Option/*<T2>*/>> zipOptionally(
    final Iterable/*<T1>*/ fst, final Iterable/*<T2>*/ snd) =>
        new _ZippedOptionalIterable(fst, snd);

class _ConcatIterable<T> extends IterableBase<T> {
  final Iterable<T> _fst;
  final Iterable<T> _snd;
  
  _ConcatIterable(this._fst, this._snd);
  
  Iterator<T> get iterator => new _ConcatIterator(_fst.iterator, _snd.iterator);
}

class _ConcatIterator<T> extends IterableBase<T> {
  final Iterator<T> _fst;
  final Iterator<T> _snd;
  
  _ConcatIterator(this._fst, this._snd);
  
  T get current => firstNotNull(_fst.current, _snd.current);
  
  bool moveNext() =>
    _fst.moveNext() ? true : _snd.moveNext();

}

class _ZippedOptionalIterable<T1,T2> extends IterableBase<Pair<Option<T1>, Option<T2>>> {
  final Iterable<T1> _fst;
  final Iterable<T2> _snd;
  
  _ZippedOptionalIterable(this._fst, this._snd);
  
  Iterator<Pair<Option<T1>, Option<T2>>> get iterator =>
      new _ZippedOptionalIterator(_fst.iterator, _snd.iterator);
  
}

class _ZippedOptionalIterator<T1,T2> implements Iterator<Pair<Option<T1>, Option<T2>>> {
  final Iterator<T1> _fst;
  final Iterator<T2> _snd;
  
  Pair<Option<T1>, Option<T2>> _current = null;
  
  _ZippedOptionalIterator(this._fst, this._snd);
  
  Pair<Option<T1>, Option<T2>> get current {
    return _current;
  }
  
  bool moveNext() {
    final Option<T1> fst = (_fst.moveNext()) ? new Option(_fst.current) : Option.NONE;
    final Option<T2> snd = (_snd.moveNext()) ? new Option(_snd.current) : Option.NONE;
    
    if (fst.isEmpty && snd.isEmpty) {
      _current = null;
      return false;
    } else {
      _current = new Pair(fst, snd);
      return true;
    }    
  }
}
