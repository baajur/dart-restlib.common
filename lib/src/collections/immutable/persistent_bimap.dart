part of collections.immutable;

class _PersistentBiMap<K,V> 
    extends _ImmutableBiMapBase<K,V> {

  static const ImmutableBiMap EMPTY = 
      const _PersistentBiMap._internal(EMPTY_DICTIONARY, EMPTY_DICTIONARY);

  final ImmutableDictionary<K,V> _delegate;
  final ImmutableDictionary<V,K> _inverse;
  
  const _PersistentBiMap._internal(this._delegate, this._inverse);
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _PersistentBiMap._internal(_inverse, _delegate);
  
  Iterator<Pair<K,V>> get iterator =>
      _delegate.iterator;
      
  Option<V> operator[](final K key) => 
      _delegate[key];
  
  ImmutableBiMap<K,V> put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    ImmutableDictionary newMap = _delegate;
    ImmutableDictionary newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.removeAt(key));  
    
    newInverse = newInverse.put(value, key);
    newMap = newMap.put(key, value);
    
    return newMap == _delegate ? this : new _PersistentBiMap._internal(newMap, newInverse);
  }
  
  ImmutableBiMap<K, V> putAll(final Iterable<Pair<K,V>> pairs) {
    if (identical(this, EMPTY) && (pairs is _PersistentBiMap)) {
      return pairs;
    } else {
      return pairs.fold(this,
          (final ImmutableBiMap<K,V> previousValue, final Pair<K,V> element) => 
              previousValue.put(element.e0, element.e1));
    }
  }
  
  ImmutableBiMap<K,V> putAllFromMap(final Map<K,V> map) {
    ImmutableBiMap<K,V> result = this;
    map.forEach((k,v) => 
        result = result.put(k, v));
    return result;
  }
  
  ImmutableBiMap<K,V> removeAt(final K key) {
    checkNotNull(key);
    
    ImmutableDictionary newMap = _delegate;
    ImmutableDictionary newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.removeAt(value));
    newMap = newMap.removeAt (key);
    
    return newMap == _delegate ? this : new _PersistentBiMap._internal(newMap, newInverse);
  }
}
