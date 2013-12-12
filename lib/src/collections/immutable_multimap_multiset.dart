part of restlib.common.collections;

abstract class ImmutableMultisetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,ImmutableMultiset<V>> {  
  ImmutableDictionary<K, ImmutableMultiset<V>> get dictionary;
  
  ImmutableMultisetMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableMultisetMultimap<K,V> insert(final K key, final V value);
  
  ImmutableMultisetMultimap<K,V> removeAt(final K key);
}