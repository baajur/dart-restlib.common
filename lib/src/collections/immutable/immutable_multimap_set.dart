part of restlib.common.collections.immutable;

abstract class ImmutableSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,FiniteSet<V>>, SetMultimap<K,V> {  
  ImmutableSetMultimap<K,V> insert(final K key, final V value);
  ImmutableSetMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  ImmutableSetMultimap<K,V> insertAllFromMap(Map<K, V> map);
  ImmutableSetMultimap<K,V> insertPair(Pair<K, V> pair);
  ImmutableSetMultimap<K,V> removeAt(final K key);
}
