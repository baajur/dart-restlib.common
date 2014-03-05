part of collections.mutable;

abstract class MutableMultimap<K, V, I extends Iterable<V>> implements Multimap<K, V, I>, MutableAssociative<K,V> {  
  I operator[](final K key);
  
  I removeAt(K key);
}

abstract class _AbstractMutableMultimap<K,V, I extends Iterable<V>> 
    extends MultimapBase<K,V,I>
    implements MutableMultimap<K, V, I> {
  final MutableDictionary<K, I> _delegate;
  
  _AbstractMutableMultimap(this._delegate);
  
  // FIXME: Maybe wrap MutableDictionary to prevent doing something dumb
  // like inserting non Sequence values
  MutableDictionary<K, I> get dictionary => _delegate;   
  
  I operator[](final K key) =>
      _delegate[key]
        .map((final I container) => container)
        .orElse(emptyValueContainer);
  
  void operator[]=(final K key, final V value) =>
      put(key, value);
  
  I _newValueContainer();
  
  void clear() =>
      _delegate.clear();
  
  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final I container) => 
                (container as MutableCollection)..add(value))
            .orCompute(() =>  
                (_newValueContainer() as MutableCollection)..add(value)));
  
  void putAll(final Iterable<Pair<K, V>> pairs) =>
      pairs.forEach((final Pair<K, V> pair) => 
          put(pair.e0, pair.e1));
  
  void putAllFromMap(final Map<K,V> map) =>
      map.forEach((final K key, final V value) => 
          put (key, value));
  
  void putPair(final Pair<K,V> pair) =>
      put(pair.e0, pair.e1);
  
  I removeAt(final K key) =>
      _delegate.removeAt(key);
}
