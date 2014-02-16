part of restlib.common.collections.immutable;

abstract class ImmutableSequenceMultimap<K,V> implements ImmutableMultimap<K,V,Sequence<V>>, SequenceMultimap<K,V> {      
  ImmutableSequence<V> call(K key);
  ImmutableSequenceMultimap<K,V> put(final K key, final V value);
  ImmutableSequenceMultimap<K,V> putAll(final Iterable<Pair<K, V>> other);
  ImmutableSequenceMultimap<K,V> putAllFromMap(Map<K, V> map);
  ImmutableSequenceMultimap<K,V> putPair(Pair<K, V> pair);
  ImmutableSequenceMultimap<K,V> removeAt(final K key);
}
