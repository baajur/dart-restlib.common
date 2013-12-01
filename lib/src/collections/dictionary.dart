part of restlib.common.collections;

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