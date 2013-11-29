part of restlib.common.collections;

abstract class MutableAssociative<K,V> implements Associative<K,V> {
  void operator[]=(final K key, final V value);
  
  void putAll(final Iterable<Pair<K, V>> other);
  
  void put(final K key, final V value);
  
  void putPair(final Pair<K,V> pair);
 
  Iterable<V> removeKey(final K key);
}