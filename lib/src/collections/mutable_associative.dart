part of restlib.common.collections;

abstract class MutableAssociative<K,V> implements Associative<K,V> {
  void operator[]=(final K key, final V value);
  
  void insertAll(final Iterable<Pair<K, V>> other);
  
  void insert(final K key, final V value);
  
  void insertPair(final Pair<K,V> pair);
 
  Iterable<V> removeAt(final K key);
}