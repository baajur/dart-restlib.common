part of restlib.common.collections;

abstract class MutableBiMap<K,V> implements BiMap<K,V>, MutableDictionary<K,V> {  
  factory MutableBiMap.hash({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ?
          pairs.fold(
              new _AbstractMutableBiMap._internal(new MutableDictionary.hash(), new MutableDictionary.hash()),  
              (final MutableBiMap<K,V> accumulator, final Pair<K,V> pair) => 
                  accumulator..put(pair.fst, pair.snd)) :
                    new _AbstractMutableBiMap._internal(new MutableDictionary.hash(), new MutableDictionary.hash());      
  
  factory MutableBiMap.splayTree({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ?
          pairs.fold(
              new _AbstractMutableBiMap._internal(new MutableDictionary.splayTree(), new MutableDictionary.splayTree()),  
              (final MutableBiMap<K,V> accumulator, final Pair<K,V> pair) => 
                  accumulator..put(pair.fst, pair.snd)) :
                    new _AbstractMutableBiMap._internal(new MutableDictionary.splayTree(), new MutableDictionary.splayTree()); 
}

class _AbstractMutableBiMap<K,V> extends ForwardingDictionary<K,V> implements MutableBiMap<K,V> {     
  final MutableDictionary<V,K> _inverse;
 
  _AbstractMutableBiMap._internal(final _MutableMapDictionary<K,V> delegate, this._inverse) : super(delegate);
  
  BiMap<V,K> get inverse =>
      new _AbstractMutableBiMap._internal(_inverse, _delegate);
      
  Option<V> operator[](final K key) => 
      (_delegate as _MutableMapDictionary<K,V>)[key];
  
  void operator[]=(final K key, final V value) => 
      put(key, value);
  
  void addAll(final Iterable<Pair<K, V>> other) =>
      other.forEach((final Pair<K,V> pair) =>
          put(pair.fst, pair.snd));
  
  void put(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    _inverse[value].map((final K key) => 
        (_delegate as _MutableMapDictionary<K,V>).remove(key));  
    
    _inverse.put(value, key);
    (_delegate as _MutableMapDictionary<K,V>).put(key, value);
  }
 
  bool remove(final K key) {
    checkNotNull(key);
    
    (_delegate as MutableDictionary<K,V>)[key]
      .map((final V value) => 
          _inverse.remove(value));
    (_delegate as MutableDictionary<K,V>).remove(key);
  }
}
