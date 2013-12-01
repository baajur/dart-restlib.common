part of restlib.common.collections;

class ImmutableSetBuilder<E> {
  final MutableSet<E> _set = new MutableSet.hash();
  
  void add(final E element) =>
      _set.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _set.addAll(elements);
  
  FiniteSet<E> build() => 
      new _ImmutableSet(
          new MutableSet.hash(elements: _set));
}

class _ImmutableSet<E> 
    extends Object
    with ForwardingSet<E>,
      ForwardingIterable<E>
    implements FiniteSet<E>, Immutable {
  final MutableSet<E> delegate;
  
  _ImmutableSet(this.delegate);
  
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