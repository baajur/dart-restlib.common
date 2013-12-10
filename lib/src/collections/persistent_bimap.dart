part of restlib.common.collections;

class _PersistentBiMapBase<K,V> 
    extends Object
    with ForwardingDictionary<K,V>, 
      ForwardingAssociative<K,V>,
      ForwardingIterable<Pair<K,V>>, 
      ToStringForwarder
    implements ImmutableBiMap<K,V>, Forwarder {
      
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745    
  static final ImmutableBiMap EMPTY = 
      new _PersistentBiMapBase._internal(
          ImmutableDictionary.EMPTY, ImmutableDictionary.EMPTY);

  final ImmutableDictionary<K,V> delegate;
  final ImmutableDictionary<V,K> _inverse;
  
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745
  _PersistentBiMapBase._internal(this.delegate, this._inverse);
  
  int get hashCode => 
      delegate.hashCode;
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _PersistentBiMapBase._internal(_inverse, delegate);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is _PersistentBiMapBase) {
      return this.delegate == other.delegate;
    } else if ((other is BiMap)) {
      // FIXME:
      return false;
    } else {
      return false;
    }
  }
      
  Option<V> operator[](final K key) => 
      delegate[key];
  
  Map<K,V> asMap() =>
      new _DictionaryAsMap(this);
  
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
  
  ImmutableBiMap<K,V> putIfAbsent(final K key, final V value) =>
      this[key]
        .map((final V value) => 
            this)
        .orCompute(() => 
            this.insert(key, value));
 
  ImmutableBiMap<K,V> insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
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
