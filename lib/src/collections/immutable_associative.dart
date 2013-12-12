part of restlib.common.collections;

abstract class ImmutableAssociative<K,V> implements Associative<K,V> {
  ImmutableAssociative<K,V> insertAll(final Iterable<Pair<K, V>> pairs);
  
  ImmutableAssociative<K,V> insertAllFromMap(final Map<K,V> map);
  
  ImmutableAssociative<K,V> insert(final K key, final V value);

  ImmutableAssociative<K,V> insertPair(final Pair<K,V> pair);
  
  ImmutableAssociative<K,V> removeAt(final K key);
}