part of restlib.common.collections;

abstract class ImmutableMultimap<K,V, I extends Iterable<V>> implements Multimap<K,V,I>, ImmutableAssociative<K,V> {  
  ImmutableMultimap<K,V,I> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableMultimap<K,V,I> insert(final K key, final V value);
  
  ImmutableMultimap<K,V,I> removeAt(final K key);
}

abstract class _ImmutableMultimapBase<K,V, I extends Iterable<V>> 
    extends _MultimapBase<K,V,I> 
    implements ImmutableMultimap<K,V, I> {  
  const _ImmutableMultimapBase(); 
  
  int get hashCode => 
      dictionary.hashCode;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableMultimap) {
      return this.dictionary == other.dictionary;
    } else {
      return false;
    }
  }
  
  ImmutableMultimap<K,V,I> insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
}
