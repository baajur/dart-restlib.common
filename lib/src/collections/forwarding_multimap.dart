part of restlib.common.collections;

class ForwardingMultimap<K,V> extends ForwardingIterable<Pair<K,V>> implements Multimap<K,V> {
  ForwardingMultimap(final Multimap<K,V> delegate) : super(delegate);
  
  Iterable<V> operator[](final K key) => (super._delegate as Multimap)[key];
  
  Dictionary<K, Iterable<V>> asDictionary() => (super._delegate as Multimap).asDictionary();
}