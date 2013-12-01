part of restlib.common.collections;

class ImmutableSequenceBuilder<E> {
  final MutableSequence<E> _sequence = new GrowableSequence();
  
  void add(final E element) =>
      _sequence.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _sequence.addAll(elements);
  
  Sequence<E> build() => 
      new _ImmutableSequence(
          new MutableFixedSizeSequence(_sequence.length)..addAll(_sequence));
}

class _ImmutableSequence<E> 
    extends Object
    with ForwardingSequence<E>,
      ForwardingIterable<E>,
      ForwardingAssociative<int,E>
    implements Sequence<E>, Immutable {
  final MutableFixedSizeSequence<E> delegate;
  
  _ImmutableSequence(this.delegate);
  
  int get hashCode =>
      computeHashCode(delegate);
  
  bool operator==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if ((other is Sequence) && (other is Immutable)) {
      return equal(this, other);
    } else {
      return false;
    }
  }
}