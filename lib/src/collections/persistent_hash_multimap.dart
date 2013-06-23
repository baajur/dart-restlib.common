part of restlib.common.collections;

class PersistentListMultimap<K,V> extends Object with IterableMixin<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentListMultimap EMPTY = 
      const PersistentListMultimap._internal(PersistentHashMap.EMPTY);
  
  final PersistentHashMap<K, PersistentList<V>> _map;
  
  const PersistentListMultimap._internal(this._map);
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((Pair<K, PersistentList<V>> pair) => 
          pair.snd.map((V value) =>
              new Pair(pair.fst, value))).iterator;
  
  PersistentList<V> operator[](final K key) =>
      _map[key].map((e) => e).orElse(PersistentList.EMPTY);
  
  Dictionary<K, PersistentList<V>> asDictionary() => _map;
  
  PersistentListMultimap<K,V> put(final K key, final V value) =>
      _map.put(key, this[key].add(value));
}

class PersistentSetMultimap<K,V> extends Object with IterableMixin<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentSetMultimap EMPTY = 
      const PersistentSetMultimap._internal(PersistentHashMap.EMPTY);
  
  final PersistentHashMap<K, PersistentHashSet<V>> _map;
  
  const PersistentSetMultimap._internal(this._map);
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((Pair<K, PersistentHashSet<V>> pair) => 
          pair.snd.map((V value) =>
              new Pair(pair.fst, value))).iterator;
  
  PersistentHashSet<V> operator[](final K key) =>
      _map[key].map((e) => e).orElse(PersistentHashSet.EMPTY);
  
  Dictionary<K, PersistentHashSet<V>> asDictionary() => _map;
  
  PersistentSetMultimap<K,V> put(final K key, final V value) =>
      _map.put(key, this[key].add(value));
}