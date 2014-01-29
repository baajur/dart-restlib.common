part of restlib.common.collections.immutable;

class CopyOnWriteDictionaryBuilder<K,V> {
  final MutableDictionary _delegate = new MutableDictionary.hash();
  
  void insert(final K key, final V value) =>
      _delegate.put(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.putAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.putPair(pair);
  
  ImmutableDictionary<K,V> build() =>
      new _CopyOnWriteDictionary(new MutableDictionary.hash(pairs:_delegate));
}

class _CopyOnWriteDictionary<K,V> 
    extends _ImmutableDictionaryBase<K,V> 
    implements CopyOnWrite {
      
  static final _CopyOnWriteDictionary EMPTY = 
      new CopyOnWriteDictionaryBuilder().build();
  
  final Dictionary _delegate;
  
  const _CopyOnWriteDictionary(this._delegate);

  Iterator<Pair<K,V>> get iterator =>
      _delegate.iterator;
  
  Option<V> operator[](final K key) =>
      _delegate[key];
  
  ImmutableDictionary<K,V> put(final K key, final V value) =>
      new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..putAll(this)
            ..put(key, value));
  
  ImmutableDictionary<K,V> putAll(final Iterable<Pair<K,V>> values) {
    if (this.isEmpty && values is _CopyOnWriteDictionary) {
      return values;
    } else {
      return new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..putAll(this)
            ..putAll(values));
    }
  }
  
  ImmutableDictionary<K,V> putAllFromMap(final Map<K,V> map) =>
      new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..putAll(this)
            ..putAllFromMap(map));
  
  ImmutableDictionary<K,V> removeAt(final K key) =>
      new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..putAll(this)
            ..removeAt(key));
}