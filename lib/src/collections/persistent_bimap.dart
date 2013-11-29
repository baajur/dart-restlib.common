part of restlib.common.collections;

class PersistentBiMap<K,V> extends ForwardingDictionary<K,V> implements BiMap<K,V> {
  static const PersistentBiMap EMPTY = 
      const PersistentBiMap._internal(
          PersistentDictionary.EMPTY, PersistentDictionary.EMPTY);
  
  factory PersistentBiMap.fromMap(final Map<K,V> map) {
    PersistentBiMap<K,V> result = EMPTY;
    map.forEach((k,v) => result = result.put(k, v));
    return result;
  }
  
  factory PersistentBiMap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    if (pairs is PersistentBiMap) {
      return pairs;
    } else if (pairs.isEmpty) {
      return EMPTY;
    } else { 
      return pairs.fold(EMPTY, 
          (final PersistentDictionary<K,V> previousValue, final Pair<K,V> element) 
            => previousValue.put(element.fst, element.snd));
    }
  }

  final PersistentDictionary _inverse;
  
  const PersistentBiMap._internal(final PersistentDictionary delegate, this._inverse) : 
    super(delegate);
  
  int get hashCode => 
      _delegate.hashCode;
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new PersistentBiMap._internal(_inverse, _delegate);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentBiMap) {
      return this._delegate == other._delegate;
    } else {
      return false;
    }
  }
      
  Option<V> operator[](final K key) => 
      (_delegate as Dictionary<K,V>)[key];
  
  PersistentBiMap<K,V> put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    PersistentDictionary newMap = _delegate;
    PersistentDictionary newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.remove(key));  
    
    newInverse = newInverse.put(value, key);
    newMap = newMap.put(key, value);
    
    return newMap == _delegate ? this : new PersistentBiMap._internal(newMap, newInverse);
  }
 
  PersistentBiMap<K,V> remove(final K key) {
    checkNotNull(key);
    
    PersistentDictionary newMap = _delegate;
    PersistentDictionary newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.remove(value));
    newMap = newMap.remove(key);
    
    return newMap == _delegate ? this : new PersistentBiMap._internal(newMap, newInverse);
  }
}
