part of restlib.common.collections;

abstract class MutableMultimap<K, V, I extends MutableCollection<V>> implements Multimap<K, V> {
  MutableDictionary<K, I> get dictionary;
  
  I operator[](final K key);
  
  void put(final K key, final V value);
  
  void putAll(final Iterable<Pair<K, V>> other);
  
  bool remove(final K key);
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
          _delegate.put(key, value);
          return value;
        });
  
  I _newValueContainer();
  
  bool containsKey(final K key) =>
      _delegate.containsKey(key);
  
  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final I container) => 
                container.add(value))
            .orCompute(() =>  
                _newValueContainer().add(value)));
  
  void putAll(final Iterable<Pair<K, V>> pairs) =>
      pairs.forEach((final Pair<K, V> pair) => 
          put(pair.fst, pair.snd));
  
  bool remove(final K key) =>
      _delegate.remove(key);
  
  String toString() => 
      _delegate.toString();
}
