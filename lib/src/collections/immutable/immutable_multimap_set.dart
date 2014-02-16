part of restlib.common.collections.immutable;

abstract class ImmutableSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,FiniteSet<V>>, SetMultimap<K,V> {  
  ImmutableSet<V> call(final K key);
  ImmutableSetMultimap<K,V> put(final K key, final V value);
  ImmutableSetMultimap<K,V> putAll(final Iterable<Pair<K, V>> other);
  ImmutableSetMultimap<K,V> putAllFromMap(Map<K, V> map);
  ImmutableSetMultimap<K,V> putPair(Pair<K, V> pair);
  ImmutableSetMultimap<K,V> removeAt(final K key);
}
