part of restlib.common.collections;

class PersistentListMultimap<K,V> extends Object with IterableMixin<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentListMultimap EMPTY = 
      const PersistentListMultimap._internal(PersistentHashMap.EMPTY);
  
  factory PersistentListMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    checkNotNull(pairs);
    return (pairs is PersistentListMultimap) ? pairs :
      pairs.fold(EMPTY, (accumulator, Pair<K,V> pair) => 
          accumulator.put(pair.fst, pair.snd));
  }
  
  final PersistentHashMap<K, PersistentList<V>> _map;
  
  const PersistentListMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((Pair<K, PersistentList<V>> pair) => 
          pair.snd.map((V value) =>
              new Pair(pair.fst, value))).iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentListMultimap) {
      return this._map == other._map;
    } else {
      return false;
    }
  }
  
  PersistentList<V> operator[](final K key) =>
      _map[key].map((e) => e).orElse(PersistentList.EMPTY);
  
  Dictionary<K, PersistentList<V>> asDictionary() => _map;
  
  PersistentListMultimap<K,V> put(final K key, final V value) =>
      new PersistentListMultimap._internal(
          _map.put(key, this[key].add(value)));
  
  String toString() => _map.toString();
}

class PersistentSetMultimap<K,V> extends Object with IterableMixin<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentSetMultimap EMPTY = 
      const PersistentSetMultimap._internal(PersistentHashMap.EMPTY);
  
  factory PersistentSetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    checkNotNull(pairs);
    return (pairs is PersistentSetMultimap) ? pairs :
      pairs.fold(EMPTY, (accumulator, Pair<K,V> pair) => 
          accumulator.put(pair.fst, pair.snd));
  }
  
  final PersistentHashMap<K, PersistentHashSet<V>> _map;
  
  const PersistentSetMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((Pair<K, PersistentHashSet<V>> pair) => 
          pair.snd.map((V value) =>
              new Pair(pair.fst, value))).iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentSetMultimap) {
      return this._map == other._map;
    } else {
      return false;
    }
  }
  
  PersistentHashSet<V> operator[](final K key) =>
      _map[key].map((e) => e).orElse(PersistentHashSet.EMPTY);
  
  Dictionary<K, PersistentHashSet<V>> asDictionary() => _map;
  
  PersistentSetMultimap<K,V> put(final K key, final V value) =>
      new PersistentSetMultimap._internal(
          _map.put(key, this[key].add(value)));
  
  String toString() => _map.toString();
}