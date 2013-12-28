part of restlib.common.collections;

class CopyOnWriteSetMultimapBuilder<K,V> extends _CopyOnWriteMultimapBuilder<K,V, FiniteSet<V>> {
  final MutableSetMultimap<K,V> _delegate = new MutableSetMultimap.hashSetHashDictionary();
  
  dynamic _newValueBuilder() =>
      new CopyOnWriteSetBuilder();
  
  ImmutableSetMultimap<K,V> _doBuild(final ImmutableDictionary<K,FiniteSet<V>> dictionary) =>
      new _CopyOnWriteSetMultimap(dictionary);
}

class _CopyOnWriteSetMultimap<K,V>
    extends _CopyOnWriteMultimap<K,V,FiniteSet<V>>
    implements ImmutableSetMultimap<K,V>, CopyOnWrite {
  
  static final _CopyOnWriteSetMultimap EMPTY = new _CopyOnWriteSetMultimap(CopyOnWrite.EMPTY_DICTIONARY);    
  
  const _CopyOnWriteSetMultimap(final ImmutableDictionary<K,FiniteSet<V>> delegate) :
    super(delegate);
  
  FiniteSet<V> get _emptyValueContainer =>
      CopyOnWrite.EMPTY_SET;
  
  CopyOnWriteSetMultimapBuilder<K,V> _newBuilder() =>
      new CopyOnWriteSetMultimapBuilder<K,V>();
}