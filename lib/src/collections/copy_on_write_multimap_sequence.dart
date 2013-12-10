part of restlib.common.collections;

class CopyOnWriteSequenceMultimapBuilder<K,V> {
  final MutableSequenceMultimap<K,V> _delegate = new MutableSequenceMultimap.hash();
  
  void insert(final K key, final V value) =>
      _delegate.insert(key, value);
  
  void insertAll(final Iterable<Pair<K,V>> pairs) =>
      _delegate.insertAll(pairs);
  
  void insertPair(final Pair<K,V> pair) =>
      _delegate.insertPair(pair);
  
  ImmutableSequenceMultimap<K,V> build() => null;
}