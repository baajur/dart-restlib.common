part of collections;

List concatLists(final Iterable<List> lists) =>
    new _ConcatList(checkNotNull(lists.toList(growable: false)));

List subList(final List list, [int start, int length]) {
  checkNotNull(list);
  start = firstNotNull(start, 0);
  length = firstNotNull(length, list.length);

  checkArgument(start >= 0 && start < list.length);
  checkArgument(length <= list.length - start);

  return new _SubList(list, start, length);
}

class _SubList<T> extends ListBase<T> implements List<T> {
  final List<T> _delegate;
  final int _start;
  final int length;

  _SubList(this._delegate, this._start, this.length);

  void set length(int length) =>
      throw new UnsupportedError("List is unmodifiable");

  void operator[]=(final int index, final T value) =>
      throw new UnsupportedError("List is unmodifiable");

  T operator[](final int index) =>
      _delegate[_start + index];
}

class _ConcatList<T> extends ListBase<T> implements List<T> {
  final List<List<T>> _lists;

  _ConcatList(this._lists);

  int get length =>
      _lists.fold(0, (final int acc, final List next) => acc + next.length);

  void set length(int length) =>
      throw new UnsupportedError("List is unmodifiable");

  void operator[]=(final int index, final T value) =>
      throw new UnsupportedError("List is unmodifiable");

  T operator[](final int index) {
    int relativeIndex = index;

    for (int i=0; i < _lists.length; i++) {
      if (relativeIndex < _lists[i].length){
        return _lists[i][relativeIndex];
      }
      relativeIndex = relativeIndex - _lists[i].length;
    }

    throw new RangeError.value(index);
  }
}