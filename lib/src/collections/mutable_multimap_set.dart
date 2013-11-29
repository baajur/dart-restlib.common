part of restlib.common.collections;

abstract class MutableSetMultimap<K, V> implements MutableMultimap<K, V, MutableSet<V>> {
  factory MutableSetMultimap.hashSetHashDictionary() => 
      new _AbstractMutableHashSetMultimap(new MutableDictionary.hash());
  
  factory MutableSetMultimap.splayTreeSetHashDictionary() => 
      new _AbstractMutableSplayTreeSetMultimap(new MutableDictionary.hash());
  
  factory MutableSetMultimap.hashSetSplayTreeDictionary() => 
      new _AbstractMutableHashSetMultimap(new MutableDictionary.splayTree());
  
  factory MutableSetMultimap.splaySetSplayTreeDictionary() => 
      new _AbstractMutableSplayTreeSetMultimap(new MutableDictionary.splayTree());
}

class _AbstractMutableHashSetMultimap<K,V> extends _AbstractMutableMultimap<K,V, MutableSet<V>> implements MutableSetMultimap<K,V> {      
  _AbstractMutableHashSetMultimap(final MutableDictionary<K, MutableSet<V>> _delegate) : super(_delegate);
  
  MutableSet<V> operator[](final K key) =>
      _delegate[key]
        .map((final MutableSet<V> set) => set)
        .orCompute(() {
          final MutableSet<V> value = new MutableSet.hash();
          _delegate.put(key, value);
          return value;
        });

  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final MutableSet<V> set) => 
                set.add(value))
            .orCompute(() =>  
                new MutableSet.hash()..add(value)));
}

class _AbstractMutableSplayTreeSetMultimap<K,V> extends _AbstractMutableMultimap<K,V, MutableSet<V>> implements MutableSetMultimap<K,V> {      
  _AbstractMutableSplayTreeSetMultimap(final MutableDictionary<K, MutableSet<V>> _delegate) : super(_delegate);
  
  MutableSet<V> operator[](final K key) =>
      _delegate[key]
        .map((final MutableSet<V> set) => set)
        .orCompute(() {
          final MutableSet<V> value = new MutableSet.splayTree();
          _delegate.put(key, value);
          return value;
        });

  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final MutableSet<V> set) => 
                set.add(value))
            .orCompute(() =>  
                new MutableSet.splayTree()..add(value)));
}