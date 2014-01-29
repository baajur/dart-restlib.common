part of restlib.common.collections.mutable;

abstract class MutableBiMap<K,V> implements BiMap<K,V>, MutableDictionary<K,V> {  
  factory MutableBiMap.hash({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ?
          pairs.fold(
              new _MutableBiMapBase._internal(new MutableDictionary.hash(), new MutableDictionary.hash()),  
              (final MutableBiMap<K,V> accumulator, final Pair<K,V> pair) => 
                  accumulator..put(pair.fst, pair.snd)) :
                    new _MutableBiMapBase._internal(new MutableDictionary.hash(), new MutableDictionary.hash());      
  
  factory MutableBiMap.splayTree({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ?
          pairs.fold(
              new _MutableBiMapBase._internal(new MutableDictionary.splayTree(), new MutableDictionary.splayTree()),  
              (final MutableBiMap<K,V> accumulator, final Pair<K,V> pair) => 
                  accumulator..put(pair.fst, pair.snd)) :
                    new _MutableBiMapBase._internal(new MutableDictionary.splayTree(), new MutableDictionary.splayTree()); 
}

class _MutableBiMapBase<K,V> 
    extends DictionaryBase<K,V>
    implements MutableBiMap<K,V> {   
  
  final MutableDictionary<K,V> _delegate;    
  final MutableDictionary<V,K> _inverse;
 
  _MutableBiMapBase._internal(this._delegate, this._inverse);
  
  BiMap<V,K> get inverse =>
      new _MutableBiMapBase._internal(_inverse, _delegate);
  
  Iterator<Pair<K,V>> get iterator => _delegate.iterator;
      
  Option<V> operator[](final K key) => 
      _delegate[key];
  
  void operator[]=(final K key, final V value) => 
      put(key, value);
  
  void clear() {
      _delegate.clear();
      _inverse.clear;
  }
  
  void putAll(final Iterable<Pair<K, V>> other) =>
      other.forEach((final Pair<K,V> pair) =>
          put(pair.fst, pair.snd));
  
  void putAllFromMap(final Map<K,V> map) =>
      map.forEach((final K key, final V value) => 
          put (key, value));
  
  void put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    _inverse[value].map((final K key) => 
        _delegate.take(key));  
    
    _inverse.put(value, key);
    _delegate.put(key, value);
  }
  
  void putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
 
  Option<V> removeAt(final K key) {
    checkNotNull(key);
    
    _delegate[key]
      .map((final V value) => 
          _inverse.removeAt(value));
    _delegate.removeAt(key);
  }
}
