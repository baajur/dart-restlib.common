part of restlib.common.collections.immutable;

abstract class ImmutableMultisetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,Multiset<V>>, MultisetMultimap<K,V> {    
  ImmutableMultisetMultimap<K,V> insert(final K key, final V value);
  ImmutableMultisetMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  ImmutableMultisetMultimap<K,V> insertAllFromMap(Map<K, V> map);
  ImmutableMultisetMultimap<K,V> insertPair(Pair<K, V> pair);
  ImmutableMultisetMultimap<K,V> removeAt(final K key);
}