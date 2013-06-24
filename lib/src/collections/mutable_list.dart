part of restlib.common.collections;

abstract class MutableList<E> implements Sequence<E> {
  factory MutableList.growable() =>
      new _GrowableList();
  
  factory MutableList.fixed(final int size) =>
      new _FixedSizeList(size);
  
  void operator[]=(int index, E element);
  void add(E value);
  
  void addAll(Iterable<E> elements);
  
  List<E> asList();
  
  void insert(int index, E element);
}

class _FixedSizeList<E> extends IterableBase<E> implements MutableList<E> {
  final List<E> _delegate;
  int _length = 0;
  
  _FixedSizeList(final int size) :
    _delegate = new List(size);
  
  Iterator<E> get iterator =>
      _delegate.take(_length).iterator;
  
  int get length => _length;
  
  Iterable<E> get reversed =>
      new _ReverseSequence(this);
  
  Option<E> operator[](final int index) {
    checkNotNull(index);
    return (index >= 0 && index < length) ?
      new Option(_delegate[index]) :
      Option.NONE;
  }
  
  void operator[]=(final int index, final E value) {
    checkNotNull(index);
    checkNotNull(value);
    
    if (index >= 0 && index < length) {
      _delegate[index] = value;
    } else if (index == length) {
      add(value);
    } else {
      throw new RangeError.value(index);
    }
  }
  
  void add(final E element) {
    checkNotNull(element);
    
    if (length < _delegate.length) {
      _delegate[length] = element;
      _length++;
    } else {
      throw new RangeError.value(length);
    }
  }
  
  void addAll(final Iterable<E> elements) =>
    checkNotNull(elements)
      .forEach((E element) => 
          add(element));
  
  List<E> asList() =>
      new UnmodifiableListView(this._delegate);
  
  E elementAt(int index) =>
      this[index].orCompute(() => throw new RangeError.range(index, 0, length - 1));
  
  void insert(final int index, final E element) {
      this[index] = element;
  }
  
  String toString() => _delegate.take(_length).toString();
}

class _GrowableList<E> extends IterableBase<E> implements MutableList<E> {
  final List<E> _delegate;
  
  _GrowableList() :
    _delegate = new List();
  
  Iterator<E> get iterator =>
      _delegate.iterator;
  
  int get length => _delegate.length;
  
  Iterable<E> get reversed =>
      new  _ReverseSequence(this);
  
  Option<E> operator[](final int index) {
    checkNotNull(index);
    return (index >= 0 && index < length) ?
      new Option(_delegate[index]) :
      Option.NONE;
  }
  
  void operator[]=(final int index, final E value) =>
      _delegate[index] = checkNotNull(value);
  
  void add(final E element) =>
      _delegate.add(checkNotNull(element));
  
  void addAll(final Iterable<E> elements) =>
    checkNotNull(elements)
      .forEach((E element) => 
          add(element));
  
  E elementAt(int index) =>
      this[index].orCompute(() => throw new RangeError.range(index, 0, length - 1));
  
  void insert(final int index, final E element) {
      this[index] = element;
  }
  
  List<E> asList() =>
      new UnmodifiableListView(this._delegate);
  
  String toString() => _delegate.toString();
}
