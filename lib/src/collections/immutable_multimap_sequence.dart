part of restlib.common.collections;

abstract class ImmutableSequenceMultimap<K,V> implements ImmutableMultimap<K,V,ImmutableSequence<V>> {
  static const ImmutableSequenceMultimap EMPTY = 
      const _PersistentSequenceMultimapBase._internal(ImmutableDictionary.EMPTY);
  
  factory ImmutableSequenceMultimap.fromMap(final Map<K,V> map) {
    ImmutableSequenceMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.insert(k, v));
    return retval;
  }
  
  factory ImmutableSequenceMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) =>
    (pairs is _PersistentSequenceMultimapBase) ? pairs : EMPTY.insertAll(pairs);
  
  ImmutableDictionary<K, ImmutableSequence<V>> get dictionary;
  
  ImmutableSequenceMultimap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableSequenceMultimap<K,V> insert(final K key, final V value);
  
  ImmutableSequenceMultimap<K,V> removeAt(final K key);
}
