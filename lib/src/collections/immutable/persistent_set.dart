part of restlib.common.collections.immutable;

class _PersistentSetBase<E> 
    extends _ImmutableSetBase<E>
    implements Persistent {
  static const ImmutableSet EMPTY = 
      const _PersistentSetBase._internal(Persistent.EMPTY_DICTIONARY);  
  
  final ImmutableDictionary<E,E> delegate;
  
  const _PersistentSetBase._internal(this.delegate);
  
  ImmutableSet<E> add(final E element) =>
      new _PersistentSetBase._internal(
        delegate.insert(element, element));
  
  ImmutableSet<E> addAll(Iterable<E> elements) =>
      elements.fold(
          this, 
          (final ImmutableSet<E> accumulator, final E element) => 
              accumulator.add(element));
  
  ImmutableSet<E> difference(FiniteSet<E> other) =>
      EMPTY.addAll(
          this.where((final E element) => 
              !other.contains(element)));
  
  ImmutableSet<E> intersection(FiniteSet<Object> other) =>
      EMPTY.addAll(
          this.where((final E element) => 
              other.contains(element)));
    
  ImmutableSet<E> union(FiniteSet<E> other) =>
      EMPTY.addAll(this).addAll(other);
  
  ImmutableSet<E> remove(final E element) {
    final ImmutableDictionary<E,E> newMap =
        delegate.removeAt(element);
    return (newMap.isEmpty) ? 
        EMPTY : new _PersistentSetBase._internal(newMap);
  }
}