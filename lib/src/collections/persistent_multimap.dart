part of restlib.common.collections;

abstract class _PersistentMultimapBase<K,V, I extends Iterable<V>> 
    extends _ImmutableMultimapBase<K,V, I> 
    implements Persistent {
  final ImmutableDictionary<K, I> dictionary;
  
  const _PersistentMultimapBase._internal(this.dictionary); 
  
  ImmutableMultimap<K,V,I> insertAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final ImmutableMultimap<K,V,I> accumulator, final Pair<K,V> pair) =>
          accumulator.insertPair(pair));
  
  ImmutableMultimap<K,V,I> insertAllFromMap(final Map<K,V> map) {
    ImmutableMultimap<K,V,I> result = this;
    map.forEach((k,v) => 
        result = result.insert(k, v));
    return result;
  }
}