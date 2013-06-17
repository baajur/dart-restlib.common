part of restlib.common.collections;

abstract class ImmutableMap<K,V> implements Iterable<Pair<K,V>> {
  int get hashCode;
  
  Iterable<K> get keys;
  
  Option<V> operator[](K key);
  
  bool operator==(object);
  
  ImmutableMap<K,V> insert(K key, V value);
  
  ImmutableMap<K,V> insertPair(Pair<K,V> pair);
  
  ImmutableMap<K,V> insertAll(Iterable<Pair<K,V>> pairs);
  
  ImmutableMap<K,V> remove(K key);
}