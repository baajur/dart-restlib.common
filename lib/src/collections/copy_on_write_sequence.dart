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
  final Sequence<E> delegate;
  
  _CopyOnWriteSequence(this.delegate);
  
  ImmutableSequence<E> get tail =>
      new _CopyOnWriteSequence(delegate.subSequence(0, length - 1));
  
  ImmutableSequence add(E element) =>
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length + 1)
            ..addAll(this)
            ..add(element));
  
  ImmutableSequence addAll(Iterable<E> elements) =>
      new _CopyOnWriteSequence(
          new MutableFixedSizeSequence(length + 1)
            ..addAll(this)
            ..addAll(elements));
  
  ImmutableSequence<E> insert(final int key, final E value);
  
  ImmutableSequence<E> insertAll(final Iterable<Pair<int, E>> other);
  

  
}