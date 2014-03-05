part of collections.immutable;

abstract class ImmutableBiMap<K,V> implements BiMap<K,V>, ImmutableDictionary<K,V> {  
  Option<V> call(K key);
  
  ImmutableBiMap<K,V> putAll(final Iterable<Pair<K, V>> other);
  
  ImmutableBiMap<K,V> put(final K key, final V value);
  
  ImmutableBiMap<K,V> putPair(final Pair<K,V> pair);
  
  ImmutableBiMap<K,V> removeAt(final K key);
  
  ImmutableBiMap<K,V> putIfAbsent(final K key, final V value);
}

abstract class _ImmutableBiMapBase<K,V> extends _ImmutableDictionaryBase<K,V> implements ImmutableBiMap<K,V> {
  const _ImmutableBiMapBase();
}