part of restlib.common.collections;

class ImmutableSetMultimapBuilder<K,V> {
  final MutableSetMultimap<K,V> _delegate = new MutableSetMultimap.hashSetHashDictionary();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  SetMultimap<K,V, dynamic> build() => null;
}