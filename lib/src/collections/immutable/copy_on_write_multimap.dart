part of restlib.common.collections.immutable;

abstract class _CopyOnWriteMultimapBuilder<K,V, I extends Iterable<V>> {
  MutableMultimap<K,V,I> get _delegate;
  
  void insert(final K key, final V value) =>
      _delegate.put(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.putAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.putPair(pair);
  
  CopyOnWriteCollectionBuilder<V> _newValueBuilder();
  
  ImmutableMultimap<K,V,I> _doBuild(final ImmutableDictionary<K,I> dictionary);
  
  ImmutableMultimap<K,V,I> build() { 
    final CopyOnWriteDictionaryBuilder builder = new CopyOnWriteDictionaryBuilder();
    
    _delegate.dictionary.forEach((final Pair<K,I> pair) =>
        builder.insert(pair.fst, (_newValueBuilder()..addAll(pair.snd)).build()));
    return _doBuild(builder.build());
  }
}

abstract class _CopyOnWriteMultimap<K,V, I extends Iterable<V>>
    extends _ImmutableMultimapBase<K,V,I>
    implements ImmutableMultimap<K,V, I>, CopyOnWrite {
  
  final ImmutableDictionary<K, I> dictionary;
  
  const _CopyOnWriteMultimap(this.dictionary);
  
  _CopyOnWriteMultimapBuilder<K,V,I> _newBuilder();
  
  ImmutableMultimap<K,V,I> put(final K key, final V value) =>
      (_newBuilder()..insertAll(this)..insert(key, value)).build();
  
  ImmutableMultimap<K,V,I> putAll(final Iterable<Pair<K,V>> pairs) =>
      (_newBuilder()..insertAll(this)..insertAll(pairs)).build();
  
  ImmutableMultimap<K,V,I> putAllFromMap(final Map<K,V> map) {
    final _CopyOnWriteMultimapBuilder<K,V,I> builder = _newBuilder()..insertAll(this);
    map.forEach((final K key, final V value) =>
        builder.insert(key, value));
    return builder.build();
  }
      
  ImmutableMultimap<K, V, I> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  ImmutableMultimap<K, V, I> removeAt(final K key) =>
      (_newBuilder()
          ..insertAll(this.where((final Pair<K,V> pair) => 
              pair.fst != key))
      ).build();
}