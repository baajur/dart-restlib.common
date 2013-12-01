part of restlib.common.collections;

abstract class PersistentSet<E> extends PersistentCollection<E> implements FiniteSet<E>{
  static const PersistentSet EMPTY = 
      const _PersistentSetBase._internal(
          PersistentDictionary.EMPTY);
  
  factory PersistentSet.from(Iterable<E> elements) =>
    (elements is _PersistentSetBase) ? elements :
      elements.fold(EMPTY, (final _PersistentSetBase<E> accumulator, final E element) => 
          accumulator.add(element));
  
  PersistentSet<E> add(E value);
  PersistentSet<E> addAll(Iterable<E> elements);
  PersistentSet<E> remove(E element);
  

  PersistentSet<E> difference(FiniteSet<E> other);
  PersistentSet<E> intersection(FiniteSet<Object> other);
  PersistentSet<E> union(FiniteSet<E> other);
}

class _PersistentSetBase<E> extends IterableBase<E> implements PersistentSet<E> {
  final PersistentDictionary<E,E> _map;
  
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
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is _PersistentSetBase) {
      return this._map == other._map;
    } else {
      return false;
    }
  }
  
  PersistentSet<E> add(final E element) =>
      new _PersistentSetBase._internal(
        _map.insert(element, element));
  
  PersistentSet<E> addAll(Iterable<E> elements) =>
      elements.fold(
          this, 
          (final PersistentSet<E> accumulator, final E element) => 
              accumulator.add(element));
  
  bool contains(final Object element) =>
      _map[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  PersistentSet<E> difference(FiniteSet<E> other) =>
      PersistentSet.EMPTY.addAll(
          this.where((final E element) => 
              !other.contains(element)));
  
  PersistentSet<E> intersection(FiniteSet<Object> other) =>
      PersistentSet.EMPTY.addAll(
          this.where((final E element) => 
              other.contains(element)));
    
  PersistentSet<E> union(FiniteSet<E> other) =>
      PersistentSet.EMPTY.addAll(this).addAll(other);
  
  PersistentSet<E> remove(final E element) {
    final PersistentDictionary<E,E> newMap =
        _map.removeAt(element);
    return (newMap.isEmpty) ? 
        PersistentSet.EMPTY : new _PersistentSetBase._internal(newMap);
  }
  
  String toString() =>
      "[" + join(", ") + "]";
}