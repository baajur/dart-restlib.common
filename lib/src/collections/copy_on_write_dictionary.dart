part of restlib.common.collections;

class CopyOnWriteDictionaryBuilder<K,V> {
  final MutableDictionary _delegate = new MutableDictionary.hash();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  ImmutableDictionary<K,V> build() =>
      new _CopyOnWriteDictionary(new MutableDictionary.hash(pairs:_delegate));
}

class _CopyOnWriteDictionary<K,V> 
    extends _ImmutableDictionaryBase<K,V> 
    implements CopyOnWrite {
  
  final Dictionary delegate;
  
  const _CopyOnWriteDictionary(this.delegate);

  Iterator<Pair<K,V>> get iterator =>
      delegate.iterator;
  
  Option<V> operator[](final K key) =>
      delegate[key];
  
  ImmutableDictionary<K,V> insert(final K key, final V value) =>
      new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..insertAll(this)
            ..insert(key, value));
  
  ImmutableDictionary<K,V> insertAll(final Iterable<Pair<K,V>> values) {
    if (this.isEmpty && values is _CopyOnWriteDictionary) {
      return values;
    } else {
      return new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..insertAll(this)
            ..insertAll(values));
    }
  }
  
  ImmutableDictionary<K,V> insertAllFromMap(final Map<K,V> map) =>
      new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..insertAll(this)
            ..insertAllFromMap(map));
  
  ImmutableDictionary<K,V> removeAt(final K key) =>
      new _CopyOnWriteDictionary(
          new MutableDictionary.hash()
            ..insertAll(this)
            ..removeAt(key));
}