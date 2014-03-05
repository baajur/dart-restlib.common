part of collections.immutable;

class _PersistentSequenceMultimapBase<K,V> 
    extends _PersistentMultimapBase<K,V,Sequence<V>> 
    implements ImmutableSequenceMultimap<K,V> {  
      
  static const ImmutableSequenceMultimap EMPTY = 
    const _PersistentSequenceMultimapBase._internal(EMPTY_DICTIONARY);   
  
  const _PersistentSequenceMultimapBase._internal(ImmutableDictionary<K, ImmutableSequence<V>> dictionary): super._internal(dictionary);
  
  ImmutableSequence get emptyValueContainer =>
      EMPTY_SEQUENCE;
  
  ImmutableSequenceMultimap<K,V> put(final K key, final V value) =>
      new _PersistentSequenceMultimapBase._internal(
          dictionary.put(key, (this[key] as ImmutableSequence).add(value)));
  
  ImmutableSequenceMultimap<K,V> removeAt(final K key) =>
      new _PersistentSequenceMultimapBase._internal(
          dictionary.removeAt(key));
}