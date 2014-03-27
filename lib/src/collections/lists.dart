part of collections;

List concatLists(final Iterable<List> lists) =>
    new _ConcatList(checkNotNull(lists).toList(growable: false));

List sublist(final List list, int startIndex, [int endIndex]) {
  checkNotNull(list);
  checkNotNull(startIndex);
  endIndex = firstNotNull(endIndex, list.length);

  checkArgument(startIndex >= 0 && startIndex <= endIndex);
  checkArgument(endIndex <= list.length);

  if(startIndex == endIndex) {
    return const[];
  }

  return new _SubList(list, startIndex, endIndex);
}

class _SubList<T> extends ListBase<T> implements List<T> {
  final List<T> _delegate;
  final int _startIndex;
  final int _endIndex;

  _SubList(this._delegate, this._startIndex, this._length);

  int get length => _endIndex - _start;

  void set length(int length) =>
      throw new UnsupportedError("List is unmodifiable");

  void operator[]=(final int index, final T value) =>
      throw new UnsupportedError("List is unmodifiable");

  T operator[](final int index) {
    checkArgument(start + index < _endIndex);
    return _delegate[_start + index];
  }
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