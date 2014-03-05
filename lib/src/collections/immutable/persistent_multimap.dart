part of collections.immutable;

abstract class _PersistentMultimapBase<K,V, I extends Iterable<V>> 
    extends _ImmutableMultimapBase<K,V, I> {
  final ImmutableDictionary<K, I> dictionary;
  
  const _PersistentMultimapBase._internal(this.dictionary); 
  
  ImmutableMultimap<K,V,I> putAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final ImmutableMultimap<K,V,I> accumulator, final Pair<K,V> pair) =>
          accumulator.putPair(pair));
  
  ImmutableMultimap<K,V,I> putAllFromMap(final Map<K,V> map) {
    ImmutableMultimap<K,V,I> result = this;
    map.forEach((k,v) => 
        result = result.put(k, v));
    return result;
  }
}