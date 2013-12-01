part of restlib.common.collections;

class ImmutableMultisetMultimapBuilder<K,V> {
  final MutableMultisetMultimap<K,V> _delegate = new MutableMultisetMultimap.hashMultisetHashDictionary();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  MultisetMultimap<K,V, dynamic> build() => null;
}