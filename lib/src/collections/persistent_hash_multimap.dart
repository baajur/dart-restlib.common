part of restlib.common.collections;

class PersistentListMultimap<K,V> extends IterableBase<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentListMultimap EMPTY = 
      const PersistentListMultimap._internal(PersistentHashMap.EMPTY);
  
  factory PersistentListMultimap.fromMap(final Map<K,V> map) {
    PersistentListMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentListMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    return (pairs is PersistentListMultimap) ? pairs :
      pairs.fold(EMPTY, (final PersistentListMultimap<K,V> accumulator, final Pair<K,V> pair) => 
          accumulator.put(pair.fst, pair.snd));
  }
  
  final PersistentHashMap<K, PersistentList<V>> _map;
  
  const PersistentListMultimap._internal(this._map);
  
  int get hashCode => 
      _map.hashCode;
  
  bool get isEmpty => 
      _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((final Pair<K, PersistentList<V>> pair) => 
          pair.snd.map((final V value) =>
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
      _map[key]
        .map((final V value) => 
            value)
        .orElse(PersistentList.EMPTY);
  
  Dictionary<K, PersistentList<V>> asDictionary() => _map;
  
  PersistentListMultimap<K,V> put(final K key, final V value) =>
      new PersistentListMultimap._internal(
          _map.put(key, this[key].add(value)));
  
  PersistentListMultimap<K,V> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  PersistentListMultimap<K,V> putAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final PersistentListMultimap<K,V> accumulator, final Pair<K,V> pair) =>
          accumulator.putPair(pair));
  
  PersistentListMultimap<K,V> remove(final K key) =>
      new PersistentListMultimap._internal(
          _map.remove(key));
  
  String toString() => 
      _map.toString();
}

class PersistentSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentSetMultimap EMPTY = 
      const PersistentSetMultimap._internal(PersistentHashMap.EMPTY);
  
  factory PersistentSetMultimap.fromMap(final Map<K,V> map) {    
    PersistentSetMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentSetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    return (pairs is PersistentSetMultimap) ? pairs :
      pairs.fold(EMPTY, (final PersistentSetMultimap<K,V> accumulator, final Pair<K,V> pair) => 
          accumulator.put(pair.fst, pair.snd));
  }
  
  final PersistentHashMap<K, PersistentHashSet<V>> _map;
  
  const PersistentSetMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _map.expand((final Pair<K, PersistentHashSet<V>> pair) => 
          pair.snd.map((final V value) =>
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
      _map[key]
        .map((final V value) => 
            value)
        .orElse(PersistentHashSet.EMPTY);
  
  Dictionary<K, PersistentHashSet<V>> asDictionary() => 
      _map;
  
  PersistentSetMultimap<K,V> put(final K key, final V value) =>
      new PersistentSetMultimap._internal(
          _map.put(key, this[key].add(value)));
  
  PersistentSetMultimap<K,V> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  PersistentSetMultimap<K,V> putAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final PersistentSetMultimap<K,V> accumulator, final Pair<K,V> pair) =>
          accumulator.putPair(pair));
  
  PersistentSetMultimap<K,V> remove(final K key) =>
      new PersistentSetMultimap._internal(
          _map.remove(key));
  
  String toString() => _map.toString();
}