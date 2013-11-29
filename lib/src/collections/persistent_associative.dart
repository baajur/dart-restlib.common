part of restlib.common.collections;

abstract class PersistentAssociative<K,V> implements Associative<K,V> {
  PersistentAssociative<K,V> putAll(final Iterable<Pair<K, V>> pairs);
  
  PersistentAssociative<K,V> put(final K key, final V value);

  PersistentAssociative<K,V> putPair(final Pair<K,V> pair);
  
  PersistentAssociative<K,V> removeAt(final K key);
}