part of collections.forwarding;

abstract class ForwardingAssociative<K,V> implements Forwarder, Associative<K,V> { 
  Iterable<K> get keys =>
      delegate.keys;
  
  Iterable<V> get values =>
      delegate.values;
  
  Iterable<V> operator[](final K key) =>
      delegate[key];
  
  Iterable<V> call(K key) =>
      delegate.call(key);
  
  bool containsKey(final K key) =>
      delegate.containsKey(key);
  
  bool containsValue(final V value) =>
      delegate.containsValue(value);
  
  Associative<K,dynamic> mapValues(mapFunc(V value)) =>
      delegate.mapValues(mapFunc);
}