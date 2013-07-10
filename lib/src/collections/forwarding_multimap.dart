part of restlib.common.collections;

class ForwardingMultimap<K,V> extends ForwardingIterable<Pair<K,V>> implements Multimap<K,V> {
  const ForwardingMultimap(final Multimap<K,V> delegate) : super(delegate);
  
  Iterable<V> operator[](final K key) => 
      (_delegate as Multimap)[key];
  
  Dictionary<K, Iterable<V>> asDictionary() => 
      (_delegate as Multimap).asDictionary();
}