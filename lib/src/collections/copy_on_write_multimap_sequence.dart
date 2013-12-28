part of restlib.common.collections;

class CopyOnWriteSequenceMultimapBuilder<K,V> extends _CopyOnWriteMultimapBuilder<K,V, Sequence<V>> {
  final MutableSequenceMultimap<K,V> _delegate = new MutableSequenceMultimap.hash();
  
  dynamic _newValueBuilder() =>
      new CopyOnWriteSequenceBuilder();
  
  ImmutableSequenceMultimap<K,V> _doBuild(final ImmutableDictionary<K,Sequence<V>> dictionary) =>
      new _CopyOnWriteSequenceMultimap(dictionary);
}

class _CopyOnWriteSequenceMultimap<K,V>
    extends _CopyOnWriteMultimap<K,V,Sequence<V>>
    implements ImmutableSequenceMultimap<K,V>, CopyOnWrite {
  
  static final _CopyOnWriteSequenceMultimap EMPTY = new _CopyOnWriteSequenceMultimap(CopyOnWrite.EMPTY_DICTIONARY);            
      
  const _CopyOnWriteSequenceMultimap(final ImmutableDictionary<K,Sequence<V>> delegate) :
    super(delegate);
  
  Sequence<V> get _emptyValueContainer =>
      CopyOnWrite.EMPTY_SEQUENCE;
  
  CopyOnWriteSequenceMultimapBuilder<K,V> _newBuilder() =>
      new CopyOnWriteSequenceMultimapBuilder<K,V>();
}