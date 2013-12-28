part of restlib.common.collections;

abstract class MutableSetMultimap<K, V> implements MutableMultimap<K, V, FiniteSet<V>>, SetMultimap<K,V> {
  factory MutableSetMultimap.hashSetHashDictionary() => 
      new _MutableHashSetMultimapBase(new MutableDictionary.hash());
  
  factory MutableSetMultimap.splayTreeSetHashDictionary() => 
      new _MutableSplayTreeSetMultimapBase(new MutableDictionary.hash());
  
  factory MutableSetMultimap.hashSetSplayTreeDictionary() => 
      new _MutableHashSetMultimapBase(new MutableDictionary.splayTree());
  
  factory MutableSetMultimap.splaySetSplayTreeDictionary() => 
      new _MutableSplayTreeSetMultimapBase(new MutableDictionary.splayTree());
}

class _MutableHashSetMultimapBase<K,V> extends _AbstractMutableMultimap<K,V, FiniteSet<V>> implements MutableSetMultimap<K,V> {      
  _MutableHashSetMultimapBase(final MutableDictionary<K, MutableSet<V>> _delegate) : super(_delegate);
  
  FiniteSet<V> get _emptyValueContainer =>
      Persistent.EMPTY_SET;
  
  MutableSet<V> _newValueContainer() =>
      new MutableSet.hash();
}

class _MutableSplayTreeSetMultimapBase<K,V> extends _AbstractMutableMultimap<K,V, FiniteSet<V>> implements MutableSetMultimap<K,V> {      
  _MutableSplayTreeSetMultimapBase(final MutableDictionary<K, MutableSet<V>> _delegate) : super(_delegate);
  
  FiniteSet<V> get _emptyValueContainer =>
      Persistent.EMPTY_SET;
  
  MutableSet<V> _newValueContainer() =>
      new MutableSet.splayTree();
}