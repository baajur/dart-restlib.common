part of restlib.common.collections;

class ImmutableDictionary<K,V> extends Object with IterableMixin<Pair<K,V>> implements Dictionary<K,V> {
  static final ImmutableDictionary EMPTY = new ImmutableDictionary._internal(new Map());
  
  factory ImmutableDictionary.fromMap(final Map<K,V> map) {
    if (map.length > 0) {
      // FIXME: Null handling
      final Map<K,V> newMap = new Map.from(map);
      return new ImmutableDictionary._internal(newMap);
    } else {
      return EMPTY;
    }
  }
  
  factory ImmutableDictionary.fromPairs(final Iterable<Pair<K,V>> pairs) {
    if (pairs is ImmutableDictionary) {
      return pairs;
    } else if (pairs.isEmpty) {
      return EMPTY;
    } else { 
      final Map<K,V> newMap = new Map();
      pairs.forEach((pair) =>
          newMap[pair.fst] = pair.snd);
      return new ImmutableDictionary._internal(newMap);
    }
  }
  
  final Map<K,V> _map;
  
  ImmutableDictionary._internal(this._map);
  
  int get hashCode => computeHashCode(this);
  
  Iterator<Pair<K,V>> get iterator => new _ImmutableMapIterator(_map);
  
  Iterable<K> get keys => _map.keys;
  
  Option<V> operator[](final K key) => new Option(_map[key]);
  
  bool operator==(object) {
    if (identical(this, object)) {
      return true;
    } else if (object is ImmutableDictionary) {
      return equal(this, object);
    } else {
      return false;
    }
  }
}

class _ImmutableMapIterator<K,V> implements Iterator<Pair<K,V>>{
  final Map<K,V> _map;
  final Iterator<K> _keysItr;
  Pair<K,V> _current = null;
  
  _ImmutableMapIterator(final Map<K,V> map) :
    _map = map,
    _keysItr = map.keys.iterator;
  
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