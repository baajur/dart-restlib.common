part of restlib.common.collections.mutable;

abstract class MutableAssociative<K,V> implements Associative<K,V> {
  void operator[]=(final K key, final V value);
  
  void clear();
  
  void putAll(final Iterable<Pair<K, V>> other);
  
  void put(final K key, final V value);
  
  void putAllFromMap(final Map<K, V> map);
  
  void putPair(final Pair<K,V> pair);
 
  Iterable<V> removeAt(final K key);
}