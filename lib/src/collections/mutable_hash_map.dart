part of restlib.common.collections;

class MutableHashMap<K,V> extends IterableBase<Pair<K,V>> implements Dictionary<K,V> {
  factory MutableHashMap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    final HashMap<K,V> delegate = new HashMap();
    pairs.forEach((pair) => delegate[pair.fst] = pair.snd);
    return new MutableHashMap._internal(delegate);
  } 
  
  final HashMap<K,V> _delegate;
  
  MutableHashMap() : this._internal(new HashMap());
    
  MutableHashMap._internal(this._delegate);
  
  bool get isEmpty => _delegate.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      new _MapIterator(_delegate);
  
  int get length => _delegate.length;
  
  Pair<K,V> get single =>
    (length == 1) ? (iterator..moveNext()..current) : throw new StateError("");
  
  Option<V> operator[](final K key) =>
    new Option(_delegate[checkNotNull(key)]);
  
  void operator[]=(final K key, final V value) =>
      _delegate[checkNotNull(key)] = checkNotNull(value);
  
  void addAll(final Iterable<Pair<K, V>> other) =>
      checkNotNull(other).forEach((Pair<K,V> pair) =>
          _delegate[pair.fst] = pair.snd);
  
  bool contains(final Pair<K,V> pair) =>
      this[checkNotNull(pair).fst].map((value) => value == pair.snd).orElse(false);
  
  void put(final K key, final V value) =>
      this[key] = value;
  
  void remove(final K key) =>
      _delegate[checkNotNull(key)] = null;
  
  String toString() => _delegate.toString();
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