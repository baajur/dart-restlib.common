part of restlib.common.collections;

class CopyOnWriteSequenceBuilder<E> {
  final MutableSequence<E> _sequence = new GrowableSequence();
  
  void add(final E element) =>
      _sequence.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _sequence.addAll(elements);
  
  ImmutableSequence<E> build() => 
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(_sequence.length)..addAll(_sequence));
}

class _CopyOnWriteSequence<E> 
    extends _ImmutableSequenceBase<E> 
    implements CopyOnWrite {
  final MutableSequence<E> delegate;
  
  _CopyOnWriteSequence(this.delegate);
  
  int get length =>
      delegate.length;
  
  ImmutableSequence<E> get tail =>
      new _CopyOnWriteSequence(delegate.subSequence(0, length - 1));
  
  Option<E> operator[](int key) => 
      delegate[key];
  
  ImmutableSequence add(E element) =>
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length + 1)
            ..addAll(this)
            ..add(element));
  
  ImmutableSequence addAll(Iterable<E> elements) {
    if (this.isEmpty && elements is _CopyOnWriteSequence) {
      return elements;
    } else {
     return new _CopyOnWriteSequence(
         new MutableFixedSizeSequence(length + 1 + elements.length)
            ..addAll(this)
            ..addAll(elements));
    }
  }
  
  E elementAt(final int index) =>
        delegate.elementAt(index);
  
  ImmutableSequence<E> insert(final int key, final E value) {
    if (key < length) {
      return new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length)
            ..addAll(this)
            ..insert(key, value));
    } else if (key == length) {
      return add(value);
    } 
    
    throw new RangeError.value(key);
  }
  
  ImmutableSequence<E> insertAll(final Iterable<Pair<int, E>> elements) =>
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length + elements.length)
            ..addAll(this)
            ..insertAll(elements));  
  
  ImmutableSequence<E> insertAllFromMap(final Map<int,E> map) =>
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length)
            ..addAll(this)
            ..insertAllFromMap(map));
  
  ImmutableSequence<E> removeAt(final int key) =>
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length)
            ..addAll(this)
            ..removeAt(key));  
}