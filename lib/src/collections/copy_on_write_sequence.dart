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
    extends _ImmutableSequenceBase<E> {
  final MutableFixedSizeSequence<E> delegate;
  
  _CopyOnWriteSequence(this.delegate);
}