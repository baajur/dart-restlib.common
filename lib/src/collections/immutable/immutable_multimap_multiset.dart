part of restlib.common.collections.immutable;

abstract class ImmutableMultisetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,Multiset<V>>, MultisetMultimap<K,V> {    
  ImmutableMultiset<V> call(K key);
  
  ImmutableMultisetMultimap<K,V> put(final K key, final V value);
  ImmutableMultisetMultimap<K,V> putAll(final Iterable<Pair<K, V>> other);
  ImmutableMultisetMultimap<K,V> putAllFromMap(Map<K, V> map);
  ImmutableMultisetMultimap<K,V> putPair(Pair<K, V> pair);
  ImmutableMultisetMultimap<K,V> removeAt(final K key);
}