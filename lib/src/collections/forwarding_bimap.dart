part of restlib.common.collections;

abstract class ForwardingBiMap<K,V, D extends BiMap<K,V>> implements Forwarder<D>, BiMap<K,V> {  
  BiMap<V,K> get inverse => 
      delegate.inverse;
}