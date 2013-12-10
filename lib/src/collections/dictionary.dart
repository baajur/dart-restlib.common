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
  
  Map<K,V> asMap() =>
      new _DictionaryAsMap(this);
  
  String toString() =>
      "{" + map((pair) => "${pair.fst} : ${pair.snd}").join(", ") + "}";
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
}