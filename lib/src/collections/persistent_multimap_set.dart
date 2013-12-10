part of restlib.common.collections;

class _PersistentSetMultimapBase<K,V> extends _PersistentMultimapBase<K,V,ImmutableSet<V>> implements ImmutableSetMultimap<K,V>{  
  const _PersistentSetMultimapBase._internal(final ImmutableDictionary<K, ImmutableSet<V>> dictionary) :
    super._internal(dictionary);
  
  ImmutableSet _emptyValueContainer() =>
      ImmutableSet.EMPTY;
  
  ImmutableSetMultimap<K,V> insert(final K key, final V value) =>
      new _PersistentSetMultimapBase._internal(
          dictionary.insert(key, this[key].add(value)));
  
  ImmutableSetMultimap<K,V> removeAt(final K key) =>
      new _PersistentSetMultimapBase._internal(
          dictionary.removeAt(key));
}