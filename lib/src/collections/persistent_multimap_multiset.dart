part of restlib.common.collections;

class _PersistentMultisetMultimapBase<K,V> 
    extends _PersistentMultimapBase<K,V,ImmutableMultiset<V>> 
    implements ImmutableMultisetMultimap<K,V>, Persistent {  
  const _PersistentMultisetMultimapBase._internal(final ImmutableDictionary<K, ImmutableMultiset<V>> dictionary) :
    super._internal(dictionary);
  
  ImmutableMultiset _emptyValueContainer() =>
      ImmutableMultiset.EMPTY;
  
  ImmutableMultisetMultimap<K,V> insert(final K key, final V value) =>
      new _PersistentMultisetMultimapBase._internal(
          dictionary.insert(key, this[key].add(value)));
  
  ImmutableMultisetMultimap<K,V> removeAt(final K key) =>
      new _PersistentMultisetMultimapBase._internal(
          dictionary.removeAt(key));
}