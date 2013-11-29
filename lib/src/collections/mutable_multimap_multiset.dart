part of restlib.common.collections;

abstract class MutableMultisetMultimap<K, V> implements MutableMultimap<K, V, MutableMultiset<V>> {
  factory MutableMultisetMultimap.hashMultisetHashDictionary() => 
      new _AbstractMutableHashMultisetMultimap(new MutableDictionary.hash());
  
  factory MutableMultisetMultimap.splayTreeMultisetHashDictionary() => 
      new _AbstractMutableSplayTreeMultisetMultimap(new MutableDictionary.hash());
  
  factory MutableMultisetMultimap.hashMultisetSplayTreeDictionary() => 
      new _AbstractMutableHashMultisetMultimap(new MutableDictionary.splayTree());
  
  factory MutableMultisetMultimap.splayTreeMultisetSplayTreeDictionary() => 
      new _AbstractMutableSplayTreeMultisetMultimap(new MutableDictionary.splayTree());
}


class _AbstractMutableHashMultisetMultimap<K,V> extends _AbstractMutableMultimap<K,V, MutableMultiset<V>> implements MutableMultisetMultimap<K,V> {      
  _AbstractMutableHashMultisetMultimap(final MutableDictionary<K, MutableMultiset<V>> _delegate) : super(_delegate);
  
  MutableMultiset<V> operator[](final K key) =>
      _delegate[key]
        .map((final MutableMultiset<V> set) => set)
        .orCompute(() {
          final MutableMultiset<V> value = new MutableMultiset.hash();
          _delegate.put(key, value);
          return value;
        });

  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final MutableMultiset<V> set) => 
                set.add(value))
            .orCompute(() =>  
                new MutableMultiset.hash()..add(value)));
}

class _AbstractMutableSplayTreeMultisetMultimap<K,V> extends _AbstractMutableMultimap<K,V, MutableMultiset<V>> implements MutableMultisetMultimap<K,V> {      
  _AbstractMutableSplayTreeMultisetMultimap(final MutableDictionary<K, MutableMultiset<V>> _delegate) : super(_delegate);
  
  MutableMultiset<V> operator[](final K key) =>
      _delegate[key]
        .map((final MutableMultiset<V> set) => set)
        .orCompute(() {
          final MutableMultiset<V> value = new MutableMultiset.splayTree();
          _delegate.put(key, value);
          return value;
        });

  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final MutableMultiset<V> set) => 
                set.add(value))
            .orCompute(() =>  
                new MutableMultiset.splayTree()..add(value)));
}