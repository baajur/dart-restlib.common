part of restlib.common.collections;

abstract class ImmutableSequenceMultimap<K,V> implements ImmutableMultimap<K,V,Sequence<V>>, SequenceMultimap<K,V> {      
  ImmutableSequenceMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableSequenceMultimap<K,V> insert(final K key, final V value);
  
  ImmutableSequenceMultimap<K,V> removeAt(final K key);
}
