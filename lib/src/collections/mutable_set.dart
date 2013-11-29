part of restlib.common.collections;

abstract class MutableSet<E> extends MutableCollection<E> {
  factory MutableSet.hash({final Iterable<E> elements}) =>
      (elements != null) ?
          elements.fold(
              new _MutableDictionaryBackedSet(new MutableDictionary.hash()), 
              (final MutableSet<E> accumulator, final E element) => 
                  accumulator..add(element)) :
            new _MutableDictionaryBackedSet(new MutableDictionary.hash());
  
  factory MutableSet.splayTree({final Iterable<E> elements}) =>
      (elements != null) ?
          elements.fold(
              new _MutableDictionaryBackedSet(new MutableDictionary.splayTree()), 
              (final MutableSet<E> accumulator, final E element) => 
                  accumulator..add(element)) :
            new _MutableDictionaryBackedSet(new MutableDictionary.splayTree());
}

class _MutableDictionaryBackedSet<E> extends IterableBase<E> implements MutableSet<E> {   
  final MutableDictionary<E,E> _map;
  
  _MutableDictionaryBackedSet(this._map);
  
  E get first =>
      _map.first.fst;
  
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
  
  void add(final E element) =>
      _map.put(element, element);
  
  void addAll(final Iterable<E> elements) =>
      elements.forEach((final E element) => 
          add(element));
  
  bool contains(final E element) =>
      _map[element]
        .map((final E v) => 
            true)
        .orElse(false);
  
  Option<E> remove(final E element) =>
      _map.removeKey(element);
}