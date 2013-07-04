part of restlib.common.collections;

class PersistentHashBiMap<K,V> extends IterableBase<Pair<K,V>> implements BiMap<K,V> {
  static const PersistentHashBiMap EMPTY = 
      const PersistentHashBiMap._internal(
          PersistentHashMap.EMPTY, PersistentHashMap.EMPTY);
  
  factory PersistentHashBiMap.fromMap(final Map<K,V> map) {
    PersistentHashBiMap<K,V> result = EMPTY;
    map.forEach((k,v) => result = result.put(k, v));
    return result;
  }
  
  factory PersistentHashBiMap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    if (pairs is PersistentHashBiMap) {
      return pairs;
    } else if (pairs.isEmpty) {
      return EMPTY;
    } else { 
      return pairs.fold(EMPTY, 
          (PersistentHashMap<K,V> previousValue, Pair<K,V> element) 
            => previousValue.put(element.fst, element.snd));
    }
  }
  
  final PersistentHashMap _map;
  final PersistentHashMap _inverse;
  
  const PersistentHashBiMap._internal(this._map, this._inverse);
  
  int get hashCode => _map.hashCode;
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new PersistentHashBiMap._internal(_inverse, _map);
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator => _map.iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentHashBiMap) {
      return this._map == other._map;
    } else {
      return false;
    }
  }
      
  Option<V> operator[](final K key) => _map[key];
  
  bool contains(final Pair<K,V> pair) => _map.contains(pair);
  
  PersistentHashBiMap<K,V> put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    PersistentHashMap newMap = _map;
    PersistentHashMap newInverse = _inverse;
    
    newInverse[value].map((key) => 
        newMap = newMap.remove(key));  
    
    newInverse = newInverse.put(value, key);
    newMap = newMap.put(key, value);
    
    return newMap == _map ? this : new PersistentHashBiMap._internal(newMap, newInverse);
  }
 
  PersistentHashBiMap<K,V> remove(final K key) {
    checkNotNull(key);
    
    PersistentHashMap newMap = _map;
    PersistentHashMap newInverse = _inverse;
    
    newMap[key].map((value) => newInverse = newInverse.remove(value));
    newMap = newMap.remove(key);
    
    return newMap == _map ? this : new PersistentHashBiMap._internal(newMap, newInverse);
  }
  
  String toString() => _map.toString();
}
