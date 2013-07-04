part of restlib.common.collections;

class MutableHashSet<E> extends IterableBase<E> {  
  factory MutableHashSet.from(final Iterable<E> elements) =>
    (elements is PersistentHashSet) ? elements :
      elements.fold(new MutableHashSet(), (accumulator, E element) => 
          accumulator.add(element));
  
  final MutableHashMap<E,E> _map;
  
  MutableHashSet() :
    this._map = new MutableHashMap();
  
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
  
  void add(final E element) =>
      _map.put(element, element);
  
  bool contains(final E element) =>
      _map[element].map((v) => true).orElse(false);
  
  void remove(final E element) =>
      _map.remove(element);
}