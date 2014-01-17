part of restlib.common.collections.forwarding;

abstract class ForwardingMultimap<K,V, I extends Iterable<V>> 
    implements Forwarder, Multimap<K,V,I> {  
  Dictionary<K, I> get dictionary => 
      delegate.dictionary;
}