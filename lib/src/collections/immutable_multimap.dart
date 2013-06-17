part of restlib.common.collections;

abstract class ImmutableMultimap<K,V> {  
  Iterable<Pair<K,V>> get entries;
  
  Iterable<K> get keys;
  
  Iterable<V> operator[](K key);
  
  ImmutableMultimap<K,V> insert(K key, V value);
  
  ImmutableMultimap<K,V> insertPair(Pair<K,V> pair);
  
  ImmutableMultimap<K,V> insertAll(Iterable<Pair<K,V>> pairs);
  
  ImmutableMultimap<K,V> insertValues(K key, Iterable<V> values);
  
  ImmutableMultimap<K,V> remove(K key, V value);
  
  ImmutableMultimap<K,V> removeAll(K key);
  
  ImmutableMultimap<K,V> removePair(Pair<K,V> pair);
}

abstract class ImmutableListMultimap<K,V> extends ImmutableMultimap<K,V>{
  int get hashCode;
  
  ImmutableList<V> operator[](K key);
  
  bool operator==(object);
  
  ImmutableListMultimap<K,V> insert(K key, V value);
  
  ImmutableListMultimap<K,V> insertPair(Pair<K,V> pair);
  
  ImmutableListMultimap<K,V> insertAll(Iterable<Pair<K,V>> pairs);
  
  ImmutableListMultimap<K,V> insertValues(K key, Iterable<V> values);
  
  ImmutableListMultimap<K,V> remove(K key, V value);
  
  ImmutableListMultimap<K,V> removeAll(K key);
  
  ImmutableListMultimap<K,V> removePair(Pair<K,V> pair);
}

abstract class ImmutableSetMultimap<K,V> extends ImmutableMultimap<K,V>{
  int get hashCode;
  
  ImmutableSet<V> operator[](K key);
  
  bool operator==(object);
  
  ImmutableSetMultimap<K,V> insert(K key, V value);
  
  ImmutableSetMultimap<K,V> insertPair(Pair<K,V> pair);
  
  ImmutableSetMultimap<K,V> insertAll(Iterable<Pair<K,V>> pairs);
  
  ImmutableSetMultimap<K,V> insertValues(K key, Iterable<V> values);
  
  ImmutableSetMultimap<K,V> remove(K key, V value);
  
  ImmutableSetMultimap<K,V> removeAll(K key);
  
  ImmutableSetMultimap<K,V> removePair(Pair<K,V> pair);
}