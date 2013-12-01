part of restlib.common.collections;

abstract class ForwardingDictionary<K,V> implements Forwarder, Dictionary<K,V> {  
  Option<V> operator[](final K key) => 
      delegate[key];
  
  Map<K,V> asMap() =>
      delegate.asMap();
}