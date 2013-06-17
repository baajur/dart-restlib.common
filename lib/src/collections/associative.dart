part of restlib.common.collections;

abstract class Associative<K,V> implements Iterable<Pair<K,V>> {
  Iterable<V> operator[](K key);
}

abstract class Dictionary<K,V> implements Associative<K,V> {
  Option<V> operator[](K key);
}

abstract class BiMap<K,V> implements Associative<K,V> {
  Option<V> operator[](K key);
  
  BiMap<V,K> inverse();
}