part of restlib.common.collections;

class CopyOnWriteBiMapBuilder<K,V> {
  final MutableBiMap _delegate = new MutableBiMap.hash();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  ImmutableBiMap<K,V> build() => 
      new _CopyOnWriteBiMap._internal(
          (new CopyOnWriteDictionaryBuilder()..insertAll(_delegate)).build(),
          (new CopyOnWriteDictionaryBuilder()..insertAll(_delegate.inverse)).build());
}

class _CopyOnWriteBiMap<K,V> 
    extends _ImmutableBiMapBase<K,V>
    implements CopyOnWrite {

  static final ImmutableBiMap EMPTY = 
      new _CopyOnWriteBiMap._internal(
          CopyOnWrite.EMPTY_DICTIONARY, CopyOnWrite.EMPTY_DICTIONARY);

  final ImmutableDictionary<K,V> _delegate;
  final ImmutableDictionary<V,K> _inverse;
  
  const _CopyOnWriteBiMap._internal(this._delegate, this._inverse);
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _CopyOnWriteBiMap._internal(_inverse, _delegate);
  
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
    
    return newMap == _delegate ? this : new _CopyOnWriteBiMap._internal(newMap, newInverse);
  }
  
  ImmutableBiMap<K, V> insertAll(final Iterable<Pair<K,V>> pairs) {
    return (new CopyOnWriteBiMapBuilder()..insertAll(this)..insertAll(pairs)).build();
  }
  
  ImmutableBiMap<K,V> insertAllFromMap(final Map<K,V> map) {
    final CopyOnWriteBiMapBuilder<K,V> builder = new CopyOnWriteBiMapBuilder();
    map.forEach((final K key, final V value) => 
        builder.insert(key, value));
    return builder.build();
  }
  
  ImmutableBiMap<K,V> removeAt(final K key) {
    checkNotNull(key);
    
    ImmutableDictionary newMap = _delegate;
    ImmutableDictionary newInverse = _inverse;
    
    return newMap[key]
      .map((final V value) {
        newInverse = newInverse.removeAt(value);
        newMap = newMap.removeAt(key);
        return new _CopyOnWriteBiMap._internal(newMap, newInverse);
      }).orElse(this);
  }
}
