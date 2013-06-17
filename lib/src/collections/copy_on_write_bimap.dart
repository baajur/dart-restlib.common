part of restlib.common.collections;

class CopyOnWriteBiMap<K,V> implements ImmutableBiMap<K,V> {
  final CopyOnWriteMap<K,V> _map;
  final CopyOnWriteMap<V,K> _inverse;
  
  const CopyOnWriteBiMap._internal(this._map, this._inverse);
  
  int get hashCode => _map.hashCode;
  
  Iterator<Pair<K,V>> get iterator => _map.iterator;
  
  Iterable<K> get keys => _map.keys;
  
  Option<V> operator[](final K key) => new Option(_map[key]);
  
  bool operator==(object) {
    if (identical(this, object)) {
      return true;
    } else if (object is ImmutableMap) {
      return equal(this, object);
    } else {
      return false;
    }
  }
  
  CopyOnWriteBiMap<K,V> insert(final K key, final V value) {
    final Map<K,V> newMap = 
        new Map.from(_map)
          ..[checkNotNull(key)] = checkNotNull(value);   
    _inverse[value].map((final K key) => newMap.remove(key));
    
    final Map<V,K> newInverse =
        new Map.from(_inverse)
          ..[value] = key;
    
    return new CopyOnWriteBiMap._internal(newMap, newInverse);
  }
  
  CopyOnWriteBiMap<K,V> insertPair(final Pair<K,V> pair) {
    checkNotNull(pair);
    return insert(pair.fst, pair.snd);
  }
  
  CopyOnWriteBiMap<K,V> insertAll(final Iterable<Pair<K,V>> pairs) {
    checkNotNull(pairs);
    final Map<K,V> newMap = new Map.from(_map);
    final Map<V,K> newInverse = new Map.from(_inverse);
    pairs.forEach((final Pair<K,V> pair) { 
      newMap[pair.fst] = pair.snd;
      _inverse[pair.snd].map((K key) => newMap.remove(pair.fst));
      newInverse[pair.snd] = pair.fst;
    }); 
   
    return new CopyOnWriteBiMap._internal(newMap, newInverse);
  }
  
  CopyOnWriteBiMap<V,K> inverse() =>
      new CopyOnWriteBiMap._internal(this._inverse, this._map);
}