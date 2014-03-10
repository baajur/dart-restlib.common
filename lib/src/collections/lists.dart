part of collections;


List concatLists(final Iterable<List> lists) =>
    new _ConcatList(checkNotNull(lists.toList(growable: false)));

class _ConcatList<T> extends ListBase<T> implements List<T> {
  final List<List<T>> _lists;
  final int length;

  _ConcatList(final List<List<T>> lists) :
    this._lists = lists,
    length = lists.fold(0, (final int acc, final List next) => acc + next.length);

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