part of restlib.common.collections;

abstract class MutableMultimap<K, V, I extends MutableCollection<V>> implements Multimap<K, V, I>, MutableAssociative<K,V> {
  MutableDictionary<K, I> get dictionary;
  
  I operator[](final K key);
  
  I removeAt(K key);
}

abstract class _AbstractMutableMultimap<K,V, I extends MutableCollection<V>> extends IterableBase<Pair<K,V>> implements MutableMultimap<K,V, I> {
  final MutableDictionary<K, I> _delegate;
  
  _AbstractMutableMultimap(this._delegate);
  
  // FIXME: Maybe wrap MutableDictionary to prevent doing something dumb
  // like inserting non Sequence values
  MutableDictionary<K, I> get dictionary => _delegate;   
    
  bool get isEmpty => 
      _delegate.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      _delegate.expand((final Pair<K, Sequence<V>> pair) =>
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  I operator[](final K key) =>
      _delegate[key]
        .map((final I container) => container)
        .orCompute(() {
          final I value = _newValueContainer();
          _delegate.insert(key, value);
          return value;
        });
  
  void operator[]=(final K key, final V value) =>
      insert(key, value);
  
  I _newValueContainer();
  
  bool containsKey(final K key) =>
      _delegate.containsKey(key);
  
  void insert(final K key, final V value) => 
      _delegate.insert(key, 
          _delegate[key]
            .map((final I container) => 
                container.add(value))
            .orCompute(() =>  
                _newValueContainer().add(value)));
  
  void insertAll(final Iterable<Pair<K, V>> pairs) =>
      pairs.forEach((final Pair<K, V> pair) => 
          insert(pair.fst, pair.snd));
  
  void insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
  I removeAt(final K key) =>
      _delegate.removeAt(key);
  
  String toString() => 
      _delegate.toString();
}
