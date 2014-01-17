part of restlib.common.collections.forwarding;

abstract class ForwardingBiMap<K,V> implements Forwarder, BiMap<K,V> {  
  BiMap<V,K> get inverse => 
      delegate.inverse;
}