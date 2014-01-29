part of restlib.common.collections.immutable;

class _PersistentSetMultimapBase<K,V> 
    extends _PersistentMultimapBase<K,V,FiniteSet<V>> 
    implements ImmutableSetMultimap<K,V>, Persistent {  
  
  static const ImmutableSetMultimap EMPTY = 
      const _PersistentSetMultimapBase._internal(Persistent.EMPTY_DICTIONARY);
  
  const _PersistentSetMultimapBase._internal(final ImmutableDictionary<K, ImmutableSet<V>> dictionary) :
    super._internal(dictionary);
  
  ImmutableSet get emptyValueContainer =>
      Persistent.EMPTY_SET;
  
  ImmutableSetMultimap<K,V> put(final K key, final V value) =>
      new _PersistentSetMultimapBase._internal(
          dictionary.put(key, (this[key] as ImmutableSet).add(value)));
  
  ImmutableSetMultimap<K,V> removeAt(final K key) =>
      new _PersistentSetMultimapBase._internal(
          dictionary.removeAt(key));
}