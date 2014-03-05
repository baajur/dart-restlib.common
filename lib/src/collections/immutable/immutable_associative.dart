part of collections.immutable;

abstract class ImmutableAssociative<K,V> implements Associative<K,V> {
  Iterable<V> call(K key);
  
  ImmutableAssociative<K,V> putAll(final Iterable<Pair<K, V>> pairs);
  
  ImmutableAssociative<K,V> putAllFromMap(final Map<K,V> map);
  
  ImmutableAssociative<K,V> put(final K key, final V value);

  ImmutableAssociative<K,V> putPair(final Pair<K,V> pair);
  
  ImmutableAssociative<K,V> removeAt(final K key);
}