part of collections.mutable;

class _MutableDictionaryBase<K,V> 
    extends DictionaryBase<K,V> implements MutableDictionary<K,V> {
  final Map<K,V> _delegate;
    
  _MutableDictionaryBase._internal(this._delegate);
  
  Iterator<Pair<K,V>> get iterator =>
      new _MapIterator(_delegate);
  
  Iterable<K> get keys =>
      _delegate.keys;
  
  Iterable<V> get values =>
      _delegate.values;
  
  int get length => 
      _delegate.length;
  
  Option<V> operator[](final K key) =>
    new Option(_delegate[checkNotNull(key)]);
  
  void operator[]=(final K key, final V value) {
      _delegate[checkNotNull(key)] = checkNotNull(value);
  }
  
  void clear() =>
      _delegate.clear();
  
  void putAll(final Iterable<Pair<K, V>> other) =>
      other.forEach((final Pair<K,V> pair) =>
          _delegate[pair.fst] = pair.snd);
  
  void putAllFromMap(final Map<K,V> map) =>
      map.forEach((final K key, final V value) => 
          put (key, value));
  
  void put(final K key, final V value) {
      this[key] = value;
  }
  
  void putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  Option<V> removeAt(final K key) {
    if (containsKey(key)) {
      final Option<V> retval = this[key];
      _delegate.remove(checkNotNull(key));
      return retval;
    } else {
      return Option.NONE;
    }
  }
}

class _MapIterator<K,V> implements Iterator<Pair<K,V>> {
  final Map<K,V> _map;
  final Iterator<K> _keysItr;
  
  _MapIterator(final Map<K,V> map) :
    _map = map,
    _keysItr = map.keys.iterator;
  
  Pair<K,V> get current =>
      new Pair(_keysItr.current, _map[_keysItr.current]);
  
  bool moveNext() =>
      _keysItr.moveNext();
}