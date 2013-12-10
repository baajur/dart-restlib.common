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
    extends _ImmutableDictionaryBase<K,V> {
  
  final MutableDictionary delegate;
  
  _CopyOnWriteDictionary(this.delegate);
  
  int get hashCode =>
      computeHashCode(delegate);
  
  bool operator ==(final other) {
    if (identical(this, other)) {
      return true;
    } else if ((other is Dictionary)) {
      if (this.length != other.length) {
        return false;
      }
      
      return every((final Pair<K,V> pair) => 
          other[pair.fst]
            .map((final V value) => 
                pair.snd == value)
            .orElse(false));
      
    } else {
      return false;
    }
  }
}