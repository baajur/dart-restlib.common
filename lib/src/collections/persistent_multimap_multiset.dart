part of restlib.common.collections;

class _PersistentMultisetMultimapBase<K,V> 
    extends _PersistentMultimapBase<K,V, Multiset<V>> 
    implements ImmutableMultisetMultimap<K,V>, Persistent {  
  
  static const ImmutableMultisetMultimap EMPTY = 
      const _PersistentMultisetMultimapBase._internal(Persistent.EMPTY_DICTIONARY);
  
  const _PersistentMultisetMultimapBase._internal(final ImmutableDictionary<K, ImmutableMultiset<V>> dictionary) :
    super._internal(dictionary);
  
  ImmutableMultiset get _emptyValueContainer =>
      Persistent.EMPTY_MULTISET;
  
  ImmutableMultisetMultimap<K,V> insert(final K key, final V value) =>
      new _PersistentMultisetMultimapBase._internal(
          dictionary.insert(key, (this[key] as ImmutableMultiset).add(value)));
  
  ImmutableMultisetMultimap<K,V> removeAt(final K key) =>
      new _PersistentMultisetMultimapBase._internal(
          dictionary.removeAt(key));
}