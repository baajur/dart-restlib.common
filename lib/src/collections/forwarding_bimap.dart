part of restlib.common.collections;

abstract class ForwardingBiMap<K,V> implements Forwarder, BiMap<K,V> {  
  BiMap<V,K> get inverse => 
      delegate.inverse;
}