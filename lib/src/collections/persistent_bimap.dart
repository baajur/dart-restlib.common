part of restlib.common.collections;

abstract class PersistentBiMap<K,V> implements BiMap<K,V>, PersistentDictionary<K,V> {
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745
  static final PersistentBiMap EMPTY = _PersistentBiMapBase.EMPTY;
  
  factory PersistentBiMap.fromMap(final Map<K,V> map) {
    PersistentBiMap<K,V> result = EMPTY;
    map.forEach((k,v) => result = result.insert(k, v));
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
            => previousValue.insert(element.fst, element.snd));
    }
  }
  
  PersistentBiMap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  PersistentBiMap<K,V> insert(final K key, final V value);
  
  PersistentBiMap<K,V> insertPair(final Pair<K,V> pair);
  
  PersistentBiMap<K,V> removeAt(final K key);
  
  PersistentBiMap<K,V> putIfAbsent(final K key, final V value);
}

class _PersistentBiMapBase<K,V> 
    extends Object
    with Forwarder<PersistentDictionary<K,V>>, 
      ForwardingDictionary<K,V, PersistentDictionary<K,V>>, 
      ForwardingAssociative<K,V, PersistentDictionary<K,V>>,
      ForwardingIterable<Pair<K,V>, PersistentDictionary<K,V>> 
    implements PersistentBiMap<K,V> {
      
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745    
  static final PersistentBiMap EMPTY = 
      new _PersistentBiMapBase._internal(
          PersistentDictionary.EMPTY, PersistentDictionary.EMPTY);

  final PersistentDictionary<K,V> delegate;
  final PersistentDictionary<V,K> _inverse;
  
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
    } else if (other is PersistentBiMap) {
      // FIXME:
      return false;
    } else {
      return false;
    }
  }
      
  Option<V> operator[](final K key) => 
      delegate[key];
  
  PersistentBiMap<K,V> insert(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    PersistentDictionary newMap = delegate;
    PersistentDictionary newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.removeAt(key));  
    
    newInverse = newInverse.insert(value, key);
    newMap = newMap.insert(key, value);
    
    return newMap == delegate ? this : new _PersistentBiMapBase._internal(newMap, newInverse);
  }
  
  PersistentBiMap<K, V> insertAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, 
          (final PersistentBiMap<K,V> previousValue, final Pair<K,V> element) 
            => previousValue.insert(element.fst, element.snd));
  
  PersistentBiMap<K,V> putIfAbsent(final K key, final V value) =>
      this[key]
        .map((final V value) => 
            this)
        .orCompute(() => 
            this.insert(key, value));
 
  PersistentBiMap<K,V> insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
  PersistentBiMap<K,V> removeAt(final K key) {
    checkNotNull(key);
    
    PersistentDictionary newMap = delegate;
    PersistentDictionary newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.removeAt(value));
    newMap = newMap.removeAt (key);
    
    return newMap == delegate ? this : new _PersistentBiMapBase._internal(newMap, newInverse);
  }
}
