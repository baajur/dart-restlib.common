part of restlib.common.collections;

abstract class ImmutableBiMap<K,V> implements BiMap<K,V>, ImmutableDictionary<K,V> {  
  ImmutableBiMap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableBiMap<K,V> insert(final K key, final V value);
  
  ImmutableBiMap<K,V> insertPair(final Pair<K,V> pair);
  
  ImmutableBiMap<K,V> removeAt(final K key);
  
  ImmutableBiMap<K,V> putIfAbsent(final K key, final V value);
}

abstract class _ImmutableBiMapBase<K,V> extends _ImmutableDictionaryBase<K,V> implements ImmutableBiMap<K,V> {
  const _ImmutableBiMapBase();
}