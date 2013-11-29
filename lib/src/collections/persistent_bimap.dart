part of restlib.common.collections;

abstract class PersistentBiMap<K,V> implements BiMap<K,V>, PersistentDictionary<K,V> {
  static const PersistentBiMap EMPTY = _PersistentBiMapBase.EMPTY;
  
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

class _PersistentBiMapBase<K,V> extends ForwardingDictionary<K,V> implements PersistentBiMap<K,V> {
  static const PersistentBiMap EMPTY = 
      const _PersistentBiMapBase._internal(
          PersistentDictionary.EMPTY, PersistentDictionary.EMPTY);

  final PersistentDictionary _inverse;
  
  const _PersistentBiMapBase._internal(final PersistentDictionary delegate, this._inverse) : 
    super(delegate);
  
  int get hashCode => 
      _delegate.hashCode;
  
  BiMap<V,K> get inverse =>
      isEmpty ? EMPTY : new _PersistentBiMapBase._internal(_inverse, _delegate);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is _PersistentBiMapBase) {
      return this._delegate == other._delegate;
    } else if (other is PersistentBiMap) {
      // FIXME:
      return false;
    } else {
      return false;
    }
  }
      
  Option<V> operator[](final K key) => 
      (_delegate as Dictionary<K,V>)[key];
  
  PersistentBiMap<K,V> insert(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    PersistentDictionary newMap = _delegate;
    PersistentDictionary newInverse = _inverse;
    
    newInverse[value].map((final K key) => 
        newMap = newMap.removeAt(key));  
    
    newInverse = newInverse.insert(value, key);
    newMap = newMap.insert(key, value);
    
    return newMap == _delegate ? this : new _PersistentBiMapBase._internal(newMap, newInverse);
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
    
    PersistentDictionary newMap = _delegate;
    PersistentDictionary newInverse = _inverse;
    
    newMap[key].map((final V value) => 
        newInverse = newInverse.removeAt(value));
    newMap = newMap.removeAt (key);
    
    return newMap == _delegate ? this : new _PersistentBiMapBase._internal(newMap, newInverse);
  }
}
