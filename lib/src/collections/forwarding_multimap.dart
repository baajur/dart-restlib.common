part of restlib.common.collections;

abstract class ForwardingMultimap<K,V,D extends Iterable<V>,M 
    extends Multimap<K,V,D>> 
    implements Forwarder<M>, Multimap<K,V,D> {  
  Dictionary<K, Iterable<V>> get dictionary => 
      delegate.dictionary;
}