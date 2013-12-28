part of restlib.common.collections;

class _PersistentBiMap<K,V> 
    extends _ImmutableBiMapBase<K,V>
    implements Persistent {

  static const ImmutableBiMap EMPTY = 
      const _PersistentBiMap._internal(
          Persistent.EMPTY_DICTIONARY, Persistent.EMPTY_DICTIONARY);

  final ImmutableDictionary<K,V> _delegate;
  final ImmutableDictionary<V,K> _inverse;
  
  const _PersistentBiMap._internal(this._delegate, this._inverse);
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _PersistentBiMap._internal(_inverse, _delegate);
  
  Iterator<Pair<K,V>> get iterator =>
      _delegate.iterator;
      
  Option<V> operator[](final K key) => 
      _delegate[key];
  
  ImmutableBiMap<K,V> insert(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    ImmutableDictionary newMap = _delegate;
    ImmutableDictionary newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.removeAt(key));  
    
    newInverse = newInverse.insert(value, key);
    newMap = newMap.insert(key, value);
    
    return newMap == _delegate ? this : new _PersistentBiMap._internal(newMap, newInverse);
  }
  
  ImmutableBiMap<K, V> insertAll(final Iterable<Pair<K,V>> pairs) {
    if (identical(this, EMPTY) && (pairs is _PersistentBiMap)) {
      return pairs;
    } else {
      return pairs.fold(this,
          (final ImmutableBiMap<K,V> previousValue, final Pair<K,V> element) => 
              previousValue.insert(element.fst, element.snd));
    }
  }
  
  ImmutableBiMap<K,V> insertAllFromMap(final Map<K,V> map) {
    ImmutableBiMap<K,V> result = this;
    map.forEach((k,v) => 
        result = result.insert(k, v));
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
