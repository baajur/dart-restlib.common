part of restlib.common.collections;

class PersistentHashBiMap<K,V> extends ForwardingDictionary<K,V> implements BiMap<K,V> {
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
          (final PersistentHashMap<K,V> previousValue, final Pair<K,V> element) 
            => previousValue.put(element.fst, element.snd));
    }
  }

  final PersistentHashMap _inverse;
  
  const PersistentHashBiMap._internal(final PersistentHashMap delegate, this._inverse) : 
    super(delegate);
  
  int get hashCode => 
      _delegate.hashCode;
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new PersistentHashBiMap._internal(_inverse, _delegate);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentHashBiMap) {
      return this._delegate == other._delegate;
    } else {
      return false;
    }
  }
      
  Option<V> operator[](final K key) => 
      (_delegate as Dictionary<K,V>)[key];
  
  PersistentHashBiMap<K,V> put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    PersistentHashMap newMap = _delegate;
    PersistentHashMap newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.remove(key));  
    
    newInverse = newInverse.put(value, key);
    newMap = newMap.put(key, value);
    
    return newMap == _delegate ? this : new PersistentHashBiMap._internal(newMap, newInverse);
  }
 
  PersistentHashBiMap<K,V> remove(final K key) {
    checkNotNull(key);
    
    PersistentHashMap newMap = _delegate;
    PersistentHashMap newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.remove(value));
    newMap = newMap.remove(key);
    
    return newMap == _delegate ? this : new PersistentHashBiMap._internal(newMap, newInverse);
  }
}
