part of restlib.common.collections;

class ImmutableBiMapBuilder<K,V> {
  final MutableBiMap _delegate = new MutableBiMap.hash();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  BiMap<K,V> build() => null;
}