part of restlib.common.collections;

class ForwardingDictionary<K,V> extends ForwardingIterable<Pair<K,V>> implements Dictionary<K,V> {
  const ForwardingDictionary(final Dictionary<K,V> delegate) : super(delegate);
  
  Option<V> operator[](final K key) => 
      (_delegate as Dictionary)[key];
}