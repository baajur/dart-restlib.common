part of restlib.common.collections;

class ForwardingBiMap<K,V> extends ForwardingDictionary<K,V> implements BiMap<K,V> {
  ForwardingBiMap(final BiMap<K,V> delegate) : super(delegate);
  
  BiMap<V,K> get inverse => (super._delegate as BiMap).inverse;
}