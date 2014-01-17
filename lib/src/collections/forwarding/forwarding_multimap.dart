part of restlib.common.collections.forwarding;

abstract class ForwardingMultimap<K,V, I extends Iterable<V>> 
    implements Forwarder, Multimap<K,V,I> {  
  Dictionary<K, I> get dictionary => 
      delegate.dictionary;
  
  I operator[](K key) =>
      delegate[key];
  
  I call(K key) =>
      delegate.call(key);
  
  Multimap<K,V,I> filterKeys(bool filterFunc(K key)) =>
      delegate.filterKeys(filterFunc);
  
  Multimap<K, dynamic, dynamic> mapValues(mapFunc(V value)) =>
      delegate.mapValues(mapFunc);
}