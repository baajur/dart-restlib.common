part of restlib.common.collections;

abstract class PersistentSet<E> extends PersistentCollection<E> {
  static const PersistentSet EMPTY = 
      const _PersistentSetBase._internal(
          PersistentDictionary.EMPTY);
  
  factory PersistentSet.from(Iterable<E> elements) =>
    (elements is _PersistentSetBase) ? elements :
      elements.fold(EMPTY, (final _PersistentSetBase<E> accumulator, final E element) => 
          accumulator.add(element));
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
        _map.put(element, element));
  
  PersistentSet<E> addAll(Iterable<E> elements) =>
      elements.fold(
          this, 
          (final PersistentSet<E> accumulator, final E element) => 
              accumulator.add(element));
  
  bool contains(final E element) =>
      _map[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  PersistentSet<E> remove(final E element) {
    final PersistentDictionary<E,E> newMap =
        _map.remove(element);
    return (newMap.isEmpty) ? 
        PersistentSet.EMPTY : new _PersistentSetBase._internal(newMap);
  }
  
  String toString() =>
      "[" + join(", ") + "]";
}