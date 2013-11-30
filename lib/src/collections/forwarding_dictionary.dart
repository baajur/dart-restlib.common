part of restlib.common.collections;

abstract class ForwardingDictionary<K,V, D extends Dictionary<K,V>> implements Forwarder<D>, Dictionary<K,V> {  
  Option<V> operator[](final K key) => 
      delegate[key];
}