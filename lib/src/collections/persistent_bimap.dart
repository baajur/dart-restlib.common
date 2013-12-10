part of restlib.common.collections;

class _PersistentBiMapBase<K,V> 
    extends _ImmutableBiMapBase<K,V>
    implements Persistent {
      
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745    
  static const ImmutableBiMap EMPTY = 
      const _PersistentBiMapBase._internal(
          ImmutableDictionary.EMPTY, ImmutableDictionary.EMPTY);

  final ImmutableDictionary<K,V> delegate;
  final ImmutableDictionary<V,K> _inverse;
  
  const _PersistentBiMapBase._internal(this.delegate, this._inverse);
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _PersistentBiMapBase._internal(_inverse, delegate);
  
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
    
    return newMap == delegate ? this : new _PersistentBiMapBase._internal(newMap, newInverse);
  }
  
  ImmutableBiMap<K, V> insertAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, 
          (final ImmutableBiMap<K,V> previousValue, final Pair<K,V> element) 
            => previousValue.insert(element.fst, element.snd));
  
  ImmutableBiMap<K,V> removeAt(final K key) {
    checkNotNull(key);
    
    ImmutableDictionary newMap = delegate;
    ImmutableDictionary newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.removeAt(value));
    newMap = newMap.removeAt (key);
    
    return newMap == delegate ? this : new _PersistentBiMapBase._internal(newMap, newInverse);
  }
}
