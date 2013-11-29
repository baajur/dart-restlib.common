part of restlib.common.collections;

abstract class PersistentAssociative<K,V> implements Associative<K,V> {
  PersistentAssociative<K,V> putAll(final Iterable<Pair<K, V>> other);
  
  PersistentAssociative<K,V> put(final K key, final V value);
 
  PersistentAssociative<K,V> removeKey(final K key);
}