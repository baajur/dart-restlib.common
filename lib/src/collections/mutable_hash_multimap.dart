part of restlib.common.collections;

class MutableListMultimap<K,V> extends IterableBase<Pair<K,V>> implements Multimap<K,V> {
  final MutableHashMap<K, PersistentList<V>> _map;
  
  MutableListMultimap() :
    _map = new MutableHashMap<K,V>();
    
  bool get isEmpty => 
      _map.isEmpty;
    
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((final Pair<K, PersistentList<V>> pair) =>
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  Sequence<V> operator[](final K key) =>
      _map[key].map((e) => 
          new ForwardingSequence(e)).orElse(PersistentList.EMPTY);

  Dictionary<K, Sequence<V>> asDictionary() => 
      new ForwardingDictionary(_map);

  void put(final K key, final V value) => 
      _map.put(key, 
          _map[key]
            .map((final PersistentList<V> list) => 
                list.add(value))
            .orCompute(() =>  
                PersistentList.EMPTY.add(value)));
  
  void remove(final K key) =>
      _map.remove(key);
  
  String toString() => 
      _map.toString();
}

class MutableSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements Multimap<K,V> {
  final MutableHashMap<K, PersistentHashSet<V>> _map;
  
  MutableSetMultimap() :
    _map = new MutableHashMap<K,V>();
    
  bool get isEmpty => _map.isEmpty;
    
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((final Pair<K, PersistentHashSet<V>> pair) =>
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  Iterable<V> operator[](final K key) =>
      _map[key].map((e) => 
          new ForwardingSequence(e)).orElse(PersistentHashSet.EMPTY);

  Dictionary<K, Sequence<V>> asDictionary() => 
      new ForwardingDictionary(_map);

  void put(final K key, final V value) => 
      _map.put(key, 
          _map[key]
            .map((final PersistentHashSet<V> set) => 
                set.add(value))
            .orCompute(() =>  
                PersistentHashSet.EMPTY.add(value)));
  
  void remove(final K key) =>
      _map.remove(key);
  
  String toString() => _map.toString();
}