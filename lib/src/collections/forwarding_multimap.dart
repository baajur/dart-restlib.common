part of restlib.common.collections;

abstract class ForwardingMultimap<K,V, I extends Iterable<V>> 
    implements Forwarder, Multimap<K,V,I> {  
  Dictionary<K, I> get dictionary => 
      delegate.dictionary;
}