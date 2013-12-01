part of restlib.common.collections;

class ImmutableDictionaryBuilder<K,V> {
  final MutableDictionary _delegate = new MutableDictionary.hash();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  Dictionary<K,V> build() =>
      new _ImmutableDictionary(new MutableDictionary.hash(pairs:_delegate));
}

class _ImmutableDictionary<K,V> 
    extends Object
    with ForwardingIterable<Pair<K,V>>,
      ForwardingAssociative<K,V>,
      ForwardingDictionary<K,V>
    implements Dictionary<K,V>, Immutable {
  
  final MutableDictionary delegate;
  
  _ImmutableDictionary(this.delegate);
  
  int get hashCode =>
      computeHashCode(delegate);
  
  bool operator ==(final other) {
    if (identical(this, other)) {
      return true;
    } else if ((other is Dictionary) && (other is Immutable)) {
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