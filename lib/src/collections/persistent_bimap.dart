part of restlib.common.collections;

class _PersistentBiMap<K,V> 
    extends _ImmutableBiMapBase<K,V>
    implements Persistent {
      
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745    
  static const ImmutableBiMap EMPTY = 
      const _PersistentBiMap._internal(
          Persistent.EMPTY_DICTIONARY, Persistent.EMPTY_DICTIONARY);

  final ImmutableDictionary<K,V> delegate;
  final ImmutableDictionary<V,K> _inverse;
  
  const _PersistentBiMap._internal(this.delegate, this._inverse);
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _PersistentBiMap._internal(_inverse, delegate);
  
  Iterator<Pair<K,V>> get iterator =>
      delegate.iterator;
      
  Option<V> operator[](final K key) => 
      delegate[key];
  
  ImmutableBiMap<K,V> insert(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    ImmutableDictionary newMap = delegate;
    ImmutableDictionary newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.removeAt(key));  
    
    newInverse = newInverse.insert(value, key);
    newMap = newMap.insert(key, value);
    
    return newMap == delegate ? this : new _PersistentBiMap._internal(newMap, newInverse);
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
    
    ImmutableDictionary newMap = delegate;
    ImmutableDictionary newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.removeAt(value));
    newMap = newMap.removeAt (key);
    
    return newMap == delegate ? this : new _PersistentBiMap._internal(newMap, newInverse);
  }
}
