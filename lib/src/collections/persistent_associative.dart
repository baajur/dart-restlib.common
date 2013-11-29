part of restlib.common.collections;

abstract class PersistentAssociative<K,V> implements Associative<K,V> {
  PersistentAssociative<K,V> insertAll(final Iterable<Pair<K, V>> pairs);
  
  PersistentAssociative<K,V> insert(final K key, final V value);

  PersistentAssociative<K,V> insertPair(final Pair<K,V> pair);
  
  PersistentAssociative<K,V> removeAt(final K key);
}