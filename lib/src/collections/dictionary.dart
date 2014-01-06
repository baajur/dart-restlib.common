part of restlib.common.collections;

abstract class _DictionaryBase<K,V> extends IterableBase<Pair<K,V>> implements Dictionary<K,V> {
  const _DictionaryBase(); 
  
  bool get isEmpty => length == 0;
  
  Iterable<K> get keys =>
      this.map((final Pair<K,V> pair) => 
          pair.fst);
  
  Iterable<V> get values =>
      this.map((final Pair<K,V> pair) => 
          pair.snd);
  
  bool contains(final Object pair) {
    if (pair is Pair) {
      return this[pair.fst]
        .map((final V value) => 
            value == pair.snd)
        .orElse(false);
    } else {
      return false;
    }
  }
  
  bool containsKey(final K key) =>
      this[key] != Option.NONE;
  
  bool containsValue(final V value) => 
      this.any((final Pair<K,V> pair) => 
          pair.snd == value);
  
  Dictionary<K, dynamic> mapValues(mapFunc(V value)) =>
      new _MappedDictionary(this, mapFunc);
  
  Map<K,V> asMap() =>
      new _DictionaryAsMap(this);
  
  String toString() =>
      "{" + map((pair) => "${pair.fst} : ${pair.snd}").join(", ") + "}";
}

class _MappedDictionary extends _DictionaryBase implements Forwarder {
  final Dictionary delegate;
  final mapFunc;
  
  _MappedDictionary(this.delegate, this.mapFunc);
  
  Iterator<Pair> get iterator =>
      delegate.map((final Pair pair) =>
          new Pair(pair.fst, mapFunc(pair.snd))).iterator;
  
  int get length =>
      delegate.length;
  
  Option operator[](final int index) =>
      delegate[index].map(mapFunc);
}

class _DictionaryAsMap<K,V> implements Forwarder, Map<K,V> {
  final Dictionary<K,V> delegate;
  
  _DictionaryAsMap(this.delegate);
  
  bool get isEmpty =>
      delegate.isEmpty;
  
  bool get isNotEmpty =>
      delegate.isNotEmpty;
  
  Iterable<K> get keys =>
      delegate.keys;
  
  int get length =>
      delegate.length;
  
  Iterable<V> get values =>
      delegate.values;
  
  V operator [](Object key) => 
      delegate[key].map((e) => e).orElse(null);
  
  void operator []=(K key, V value) =>
      throw new UnsupportedError("Map is read only");
  
  void addAll(Map<K, V> other) =>
      throw new UnsupportedError("Map is read only");
  
  void clear() =>
      throw new UnsupportedError("Map is read only");
  
  bool containsKey(Object key) =>
      delegate.containsKey(key);

  bool containsValue(Object value) =>
      delegate.contains(value);
  
  void forEach(void f(K key, V value)) =>
      delegate.forEach((final Pair<K,V> pair) => f(pair.fst, pair.snd));
  
  V putIfAbsent(K key, V ifAbsent())  =>
      throw new UnsupportedError("Map is read only");
  
  V remove(Object key) =>
      throw new UnsupportedError("Map is read only");
  
  String toString() =>
      delegate.toString();
}

class _MapAsDictionary<K,V> extends _DictionaryBase<K,V> {
  final Map<K,V> _delegate;
  
  _MapAsDictionary(delegate) :
    _delegate = new UnmodifiableMapView(delegate);
  
  Iterator<Pair<K,V>> get iterator =>
      _delegate.keys.map((final K key) => 
          new Pair(key, _delegate[key])).iterator;
  
  Iterable<K> get keys =>
      _delegate.keys;
  
  int get length =>
      _delegate.length;
  
  Iterable<V> get values =>
      _delegate.values;
  
  Option<V> operator[](final K key) =>
      new Option(_delegate[key]);
  
  Map<K,V> asMap() =>
      _delegate;
  
  bool containsKey(Object key) =>
      _delegate.containsKey(key);

  bool containsValue(Object value) =>
      _delegate.containsValue(value);
}