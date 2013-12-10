part of restlib.common.collections;

class _PersistentSetBase<E> extends _ImmutableSetBase<E> {
  final ImmutableDictionary<E,E> _map;
  
  const _PersistentSetBase._internal(this._map);
  
  E get first =>
      _map.first.fst;
  
  int get hashCode => 
      _map.hashCode;
  
  bool get isEmpty =>
      _map.isEmpty;
  
  Iterator<E> get iterator =>
      _map.map((final Pair<E,E> pair) => 
          pair.fst).iterator;
  
  E get last =>
      _map.last.fst;
  
  int get length =>
      _map.length;
  
  E get single =>
      _map.single.fst;
  
  ImmutableSet<E> add(final E element) =>
      new _PersistentSetBase._internal(
        _map.insert(element, element));
  
  ImmutableSet<E> addAll(Iterable<E> elements) =>
      elements.fold(
          this, 
          (final ImmutableSet<E> accumulator, final E element) => 
              accumulator.add(element));
  
  bool contains(final Object element) =>
      _map[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  ImmutableSet<E> difference(FiniteSet<E> other) =>
      ImmutableSet.EMPTY.addAll(
          this.where((final E element) => 
              !other.contains(element)));
  
  ImmutableSet<E> intersection(FiniteSet<Object> other) =>
      ImmutableSet.EMPTY.addAll(
          this.where((final E element) => 
              other.contains(element)));
    
  ImmutableSet<E> union(FiniteSet<E> other) =>
      ImmutableSet.EMPTY.addAll(this).addAll(other);
  
  ImmutableSet<E> remove(final E element) {
    final ImmutableDictionary<E,E> newMap =
        _map.removeAt(element);
    return (newMap.isEmpty) ? 
        ImmutableSet.EMPTY : new _PersistentSetBase._internal(newMap);
  }
}