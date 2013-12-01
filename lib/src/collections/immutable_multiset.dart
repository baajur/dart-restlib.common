part of restlib.common.collections;

class ImmutableMultisetBuilder<E> {
  final MutableMultiset<E> _set = new MutableMultiset.hash();
  
  void add(final E element) =>
      _set.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _set.addAll(elements);
  
  FiniteSet<E> build() => 
      new _ImmutableSet(
          new MutableSet.hash(elements: _set));
}

class _ImmutableMultiset<E> 
    extends Object
    with ForwardingMultiset<E>,
      ForwardingIterable<E>
    implements Multiset<E>, Immutable {
  final MutableMultiset<E> delegate;
  
  _ImmutableMultiset(this.delegate);
  
  int get hashCode =>
      computeHashCode(delegate);
  
  bool operator==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if ((other is FiniteSet) && (other is Immutable)) {
      return equal(this, other);
    } else {
      return false;
    }
  }
}