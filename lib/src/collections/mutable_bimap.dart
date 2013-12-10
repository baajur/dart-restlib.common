part of restlib.common.collections;

abstract class MutableBiMap<K,V> implements BiMap<K,V>, MutableDictionary<K,V> {  
  factory MutableBiMap.hash({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ?
          pairs.fold(
              new _MutableBiMapBase._internal(new MutableDictionary.hash(), new MutableDictionary.hash()),  
              (final MutableBiMap<K,V> accumulator, final Pair<K,V> pair) => 
                  accumulator..insert(pair.fst, pair.snd)) :
                    new _MutableBiMapBase._internal(new MutableDictionary.hash(), new MutableDictionary.hash());      
  
  factory MutableBiMap.splayTree({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ?
          pairs.fold(
              new _MutableBiMapBase._internal(new MutableDictionary.splayTree(), new MutableDictionary.splayTree()),  
              (final MutableBiMap<K,V> accumulator, final Pair<K,V> pair) => 
                  accumulator..insert(pair.fst, pair.snd)) :
                    new _MutableBiMapBase._internal(new MutableDictionary.splayTree(), new MutableDictionary.splayTree()); 
}

class _MutableBiMapBase<K,V> 
    extends _DictionaryBase<K,V>
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
      insert(key, value);
  
  void clear() {
      _delegate.clear();
      _inverse.clear;
  }
  
  void insertAll(final Iterable<Pair<K, V>> other) =>
      other.forEach((final Pair<K,V> pair) =>
          insert(pair.fst, pair.snd));
  
  void insert(final K key, final V value) {
    checkNotNull(key);
    checkNotNull(value);
    
    _inverse[value].map((final K key) => 
        _delegate.take(key));  
    
    _inverse.insert(value, key);
    _delegate.insert(key, value);
  }
  
  void insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
 
  Option<V> removeAt(final K key) {
    checkNotNull(key);
    
    _delegate[key]
      .map((final V value) => 
          _inverse.removeAt(value));
    _delegate.removeAt(key);
  }
}
