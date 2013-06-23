part of restlib.common.collections;

class PersistentHashSet<E> extends Object with IterableMixin<E> {
  static const PersistentHashSet EMPTY = 
      const PersistentHashSet._internal(
          PersistentHashMap.EMPTY);
  
  final PersistentHashMap<E,E> _map;
  
  const PersistentHashSet._internal(this._map);
  
  E get first =>
      _map.first.fst;
  
  bool get isEmpty =>
      _map.isEmpty;
  
  Iterator<E> get iterator =>
      _map.map((Pair<E,E> pair) => pair.fst).iterator;
  
  E get last =>
      _map.last.fst;
  
  int get length =>
      _map.length;
  
  E get single =>
      _map.single.fst;
  
  PersistentHashSet<E> add(final E element) =>
      new PersistentHashSet._internal(
        _map.put(element, element));
  
  bool contains(final E element) =>
      _map[element].map((v) => true).orElse(false);
  
  PersistentHashSet<E> remove(final E element) {
    final PersistentHashMap<E,E> newMap =
        _map.remove(element);
    return (newMap.isEmpty) ? 
        EMPTY : new PersistentHashSet._internal(newMap);
  }
}