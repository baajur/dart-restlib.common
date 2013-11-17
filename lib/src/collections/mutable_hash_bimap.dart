part of restlib.common.collections;

class MutableHashBiMap<K,V> extends ForwardingDictionary<K,V> implements BiMap<K,V> {  
  factory MutableHashBiMap.fromMap(final Map<K,V> map) {
    final MutableHashBiMap<K,V> retval = new MutableHashBiMap();
    map.forEach((k,v) => retval.put(k, v));
    return retval;
  }
  
  factory MutableHashBiMap.fromPairs(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(new MutableHashBiMap<K,V>(), 
          (final MutableHashBiMap<K,V> accumulator, final Pair<K,V> pair) => 
              accumulator..put(pair.fst, pair.snd));
 
  final MutableHashMap<V,K> _inverse;
  
  MutableHashBiMap() : this._internal(new MutableHashMap<K,V>(), new MutableHashMap<V, K>());
  
  MutableHashBiMap._internal(final MutableHashMap<K,V> delegate, this._inverse) : super(delegate);
  
  BiMap<V,K> get inverse =>
      new MutableHashBiMap._internal(_inverse, _delegate);
      
  Option<V> operator[](final K key) => 
      (_delegate as MutableHashMap<K,V>)[key];
  
  void operator[]=(final K key, final V value) => 
      put(key, value);
  
  void put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    _inverse[value].map((final K key) => 
        (_delegate as MutableHashMap<K,V>).remove(key));  
    
    _inverse.put(value, key);
    (_delegate as MutableHashMap<K,V>).put(key, value);
  }
 
  void remove(final K key) {
    checkNotNull(key);
    
    (_delegate as MutableHashMap<K,V>)[key]
      .map((final V value) => 
          _inverse.remove(value));
    (_delegate as MutableHashMap<K,V>).remove(key);
  }
}
