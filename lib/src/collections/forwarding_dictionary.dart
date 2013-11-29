part of restlib.common.collections;

class ForwardingDictionary<K,V> extends ForwardingIterable<Pair<K,V>> implements Dictionary<K,V> {
  const ForwardingDictionary(final Dictionary<K,V> delegate) : super(delegate);
  
  Iterable<K> get keys =>
      (_delegate as Dictionary).keys;
  
  Iterable<V> get values =>
      (_delegate as Dictionary).values;
  
  Option<V> operator[](final K key) => 
      (_delegate as Dictionary)[key];
  
  bool containsKey(final K key) =>
      (_delegate as Dictionary).containsKey(key);
  
  bool containsValue(V value) =>
      (_delegate as Dictionary).containsValue(value);
}