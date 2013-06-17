part of restlib.common.collections;

class CopyOnWriteMap<K,V> implements ImmutableMap<K,V> {
  static final CopyOnWriteMap EMPTY = new CopyOnWriteMap._internal(new Map());
  
  final Map<K,V> _map;
  
  const CopyOnWriteMap._internal(this._map);
  
  int get hashCode => computeHashCode(this);
  
  Iterator<Pair<K,V>> get iterator => new _CopyOnWriteMapIterator(_map);
  
  Iterable<K> get keys => _map.keys;
  
  Option<V> operator[](final K key) => new Option(_map[key]);
  
  bool operator==(object) {
    if (identical(this, object)) {
      return true;
    } else if (object is ImmutableMap) {
      return equal(this, object);
    } else {
      return false;
    }
  }
  
  ImmutableMap<K,V> insert(final K key, final V value) {
    final Map<K,V> newMap = 
        new Map.from(_map)
          ..[checkNotNull(key)] = checkNotNull(value);
    return new CopyOnWriteMap._internal(newMap);
  }
  
  ImmutableMap<K,V> insertPair(final Pair<K,V> pair) {
    checkNotNull(pair);
    return insert(pair.fst, pair.snd);
  }
  
  ImmutableMap<K,V> insertAll(final Iterable<Pair<K,V>> pairs) {
    checkNotNull(pairs);
    final Map<K,V> newMap = new Map.from(_map);
    pairs.forEach((Pair<K,V> pair) => newMap[pair.fst] = pair.snd); 
  }
}

class _CopyOnWriteMapIterator<K,V> implements Iterator<Pair<K,V>>{
  final CopyOnWriteMap<K,V> _map;
  final Iterator<K> _keysItr;
  Pair<K,V> _current = null;
  
  _CopyOnWriteMapIterator(final Map<K,V> map) :
    _map = map,
    _keysItr = map.keys;
  
  Pair<K,V> get current => _current;
  
  bool moveNext() {
    if (_keysItr.moveNext()) {
      _current = new Pair(_keysItr.current, _map[_keysItr.current]);
      return true;
    } else {
      _current = null;
      return false;
    }
  }  
}

