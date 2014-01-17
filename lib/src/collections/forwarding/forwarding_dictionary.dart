part of restlib.common.collections.forwarding;

abstract class ForwardingDictionary<K,V> implements Forwarder, Dictionary<K,V> {  
  Option<V> operator[](final K key) => 
      delegate[key];
  
  Map<K,V> asMap() =>
      delegate.asMap();
  
  Option<V> call(K key) =>
      delegate.call(key);
  
  Dictionary<K,V> filterKeys(bool filterFunc(K key)) =>
      delegate.filterKeys(filterFunc);
  
  Dictionary<K, dynamic> mapValues(mapFunc(V value)) =>
      delegate.mapValue(mapFunc);
}