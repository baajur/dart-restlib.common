part of restlib.common.collections;

abstract class ForwardingAssociative<K,V, D extends Associative<K,V>> implements Forwarder<D>, Associative<K,V> { 
  Iterable<K> get keys =>
      delegate.keys;
  
  Iterable<V> get values =>
      delegate.values;
  
  Iterable<V> operator[](final K key) =>
      delegate[key];
  
  bool containsKey(final K key) =>
      delegate.containsKey(key);
  
  bool containsValue(final V value) =>
      delegate.containsValue(value);
}