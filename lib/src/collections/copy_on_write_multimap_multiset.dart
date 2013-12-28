part of restlib.common.collections;

class CopyOnWriteMultisetMultimapBuilder<K,V> extends _CopyOnWriteMultimapBuilder<K,V, Multiset<V>> {
  final MutableMultisetMultimap<K,V> _delegate = new MutableMultisetMultimap.hashMultisetHashDictionary();
  
  dynamic _newValueBuilder() =>
      new CopyOnWriteMultisetBuilder();
}

class _CopyOnWriteMultisetMultimap<K,V>
    extends _CopyOnWriteMultimap<K,V,Multiset<V>>
    implements ImmutableMultisetMultimap<K,V>, CopyOnWrite {
      
  static final _CopyOnWriteMultisetMultimap EMPTY = new _CopyOnWriteMultisetMultimap(CopyOnWrite.EMPTY_DICTIONARY);        
  
  const _CopyOnWriteMultisetMultimap(final ImmutableDictionary<K, Multiset<V>> delegate) :
    super(delegate);
  
  Multiset<V> get _emptyValueContainer =>
      CopyOnWrite.EMPTY_MULTISET;
  
  CopyOnWriteMultisetMultimapBuilder<K,V> _newBuilder() =>
      new CopyOnWriteMultisetMultimapBuilder<K,V>();
}