part of restlib.common.collections;

abstract class ImmutableSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V,ImmutableSet<V>> {
  static const ImmutableSetMultimap EMPTY = 
      const _PersistentSetMultimapBase._internal(ImmutableDictionary.EMPTY);
  
  factory ImmutableSetMultimap.fromMap(final Map<K,V> map) {    
    ImmutableSetMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.insert(k, v));
    return retval;
  }
  
  factory ImmutableSetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) => 
      (pairs is ImmutableSetMultimap) ? pairs : EMPTY.insertAll(pairs);

  ImmutableDictionary<K, ImmutableSet<V>> get dictionary;
  
  ImmutableSetMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableSetMultimap<K,V> insert(final K key, final V value);
  
  ImmutableSetMultimap<K,V> removeAt(final K key);
}
