part of restlib.common.collections;

class MutableHashBiMap<K,V> extends IterableBase<Pair<K,V>> implements BiMap<K,V> {  
  factory MutableHashBiMap.fromMap(final Map<K,V> map) {
    final MutableHashBiMap<K,V> retval = new MutableHashBiMap();
    map.forEach((k,v) => retval.put(k, v));
    return retval;
  }
  
  factory MutableHashBiMap.fromPairs(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(new MutableHashBiMap(), (result, pair) => 
          result..put(pair.fst, pair.snd));
  
  final MutableHashMap _map;
  final MutableHashMap _inverse;
  
  MutableHashBiMap() : this._internal(new MutableHashMap(), new MutableHashMap());
  
  MutableHashBiMap._internal(this._map, this._inverse);
  
  BiMap<V,K> get inverse =>
      new MutableHashBiMap._internal(_inverse, _map);
  
  bool get isEmpty => _map.isEmpty;
  
  Iterator<Pair<K,V>> get iterator => _map.iterator;
      
  Option<V> operator[](final K key) => _map[key];
  
  void operator[]=(final K key, final V value) => put(key, value);
  
  bool contains(final Pair<K,V> pair) => _map.contains(pair);
  
  void put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    _inverse[value].map((key) => 
        _map.remove(key));  
    
    _inverse.put(value, key);
    _map.put(key, value);
  }
 
  void remove(final K key) {
    checkNotNull(key);
    
    _map[key].map((value) => _inverse.remove(value));
    _map.remove(key);
  }
  
  String toString() => _map.toString();
}
