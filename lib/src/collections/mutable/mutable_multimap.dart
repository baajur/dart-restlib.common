part of restlib.common.collections.mutable;

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
      insert(key, value);
  
  I _newValueContainer();
  
  void clear() =>
      _delegate.clear();
  
  void insert(final K key, final V value) => 
      _delegate.insert(key, 
          _delegate[key]
            .map((final I container) => 
                (container as MutableCollection)..add(value))
            .orCompute(() =>  
                (_newValueContainer() as MutableCollection)..add(value)));
  
  void insertAll(final Iterable<Pair<K, V>> pairs) =>
      pairs.forEach((final Pair<K, V> pair) => 
          insert(pair.fst, pair.snd));
  
  void insertAllFromMap(final Map<K,V> map) =>
      map.forEach((final K key, final V value) => 
          insert (key, value));
  
  void insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
  I removeAt(final K key) =>
      _delegate.removeAt(key);
}
