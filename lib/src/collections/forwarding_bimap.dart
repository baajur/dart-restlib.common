part of restlib.common.collections;

class ForwardingBiMap<K,V> extends ForwardingDictionary<K,V> implements BiMap<K,V> {
  const ForwardingBiMap(final BiMap<K,V> delegate) : super(delegate);
  
  BiMap<V,K> get inverse => 
      (_delegate as BiMap).inverse;
}