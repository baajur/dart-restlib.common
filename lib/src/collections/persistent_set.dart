part of restlib.common.collections;

class PersistentSet<E> extends IterableBase<E> {
  static const PersistentSet EMPTY = 
      const PersistentSet._internal(
          PersistentDictionary.EMPTY);
  
  factory PersistentSet.from(Iterable<E> elements) =>
    (elements is PersistentSet) ? elements :
      elements.fold(EMPTY, (final PersistentSet<E> accumulator, final E element) => 
          accumulator.add(element));

  final PersistentDictionary<E,E> _map;
  
  const PersistentSet._internal(this._map);
  
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
    } else if (other is PersistentSet) {
      return this._map == other._map;
    } else {
      return false;
    }
  }
  
  PersistentSet<E> add(final E element) =>
      new PersistentSet._internal(
        _map.put(element, element));
  
  bool contains(final E element) =>
      _map[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  PersistentSet<E> remove(final E element) {
    final PersistentDictionary<E,E> newMap =
        _map.remove(element);
    return (newMap.isEmpty) ? 
        EMPTY : new PersistentSet._internal(newMap);
  }
  
  String toString() =>
      "[" + join(", ") + "]";
}