part of restlib.common.collections;

class ForwardingMultimap<K,V> extends ForwardingIterable<Pair<K,V>> implements Multimap<K,V> {
  const ForwardingMultimap(final Multimap<K,V> delegate) : super(delegate);
  
  Dictionary<K, Iterable<V>> get dictionary => 
      (_delegate as Multimap).dictionary;
  
  Iterable<V> operator[](final K key) => 
      (_delegate as Multimap)[key];
  
  bool containsKey(final K key) =>
      (_delegate as Multimap).containsKey(key);

}