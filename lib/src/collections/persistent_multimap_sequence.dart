part of restlib.common.collections;

class _PersistentSequenceMultimapBase<K,V> 
    extends _PersistentMultimapBase<K,V,Sequence<V>> 
    implements ImmutableSequenceMultimap<K,V>, Persistent {  
      
  static const ImmutableSequenceMultimap EMPTY = 
    const _PersistentSequenceMultimapBase._internal(Persistent.EMPTY_DICTIONARY);   
  
  const _PersistentSequenceMultimapBase._internal(ImmutableDictionary<K, ImmutableSequence<V>> dictionary): super._internal(dictionary);
  
  ImmutableSequence get _emptyValueContainer =>
      Persistent.EMPTY_SEQUENCE;
  
  ImmutableSequenceMultimap<K,V> insert(final K key, final V value) =>
      new _PersistentSequenceMultimapBase._internal(
          dictionary.insert(key, (this[key] as ImmutableSequence).add(value)));
  
  ImmutableSequenceMultimap<K,V> removeAt(final K key) =>
      new _PersistentSequenceMultimapBase._internal(
          dictionary.removeAt(key));
}