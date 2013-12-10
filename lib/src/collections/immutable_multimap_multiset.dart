part of restlib.common.collections;

abstract class ImmutableMultisetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,ImmutableMultiset<V>> {
  static const ImmutableMultisetMultimap EMPTY = 
      const _PersistentMultisetMultimapBase._internal(ImmutableDictionary.EMPTY);
  
  factory ImmutableMultisetMultimap.fromMap(final Map<K,V> map) {    
    ImmutableMultisetMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.insert(k, v));
    return retval;
  }
  
  factory ImmutableMultisetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) => 
      (pairs is ImmutableMultisetMultimap) ? pairs : EMPTY.insertAll(pairs);

  ImmutableDictionary<K, ImmutableMultiset<V>> get dictionary;
  
  ImmutableMultisetMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableMultisetMultimap<K,V> insert(final K key, final V value);
  
  ImmutableMultisetMultimap<K,V> removeAt(final K key);
}