part of restlib.common.collections;

abstract class MutableMultisetMultimap<K, V> implements MutableMultimap<K, V, MutableMultiset<V>>, MultisetMultimap<K, V, MutableMultiset<V>> {
  factory MutableMultisetMultimap.hashMultisetHashDictionary() => 
      new _MutableHashMultisetMultimapBase(new MutableDictionary.hash());
  
  factory MutableMultisetMultimap.splayTreeMultisetHashDictionary() => 
      new _MutableSplayTreeMultisetMultimapBase(new MutableDictionary.hash());
  
  factory MutableMultisetMultimap.hashMultisetSplayTreeDictionary() => 
      new _MutableHashMultisetMultimapBase(new MutableDictionary.splayTree());
  
  factory MutableMultisetMultimap.splayTreeMultisetSplayTreeDictionary() => 
      new _MutableSplayTreeMultisetMultimapBase(new MutableDictionary.splayTree());
}


class _MutableHashMultisetMultimapBase<K,V> extends _AbstractMutableMultimap<K,V, MutableMultiset<V>> implements MutableMultisetMultimap<K,V> {      
  _MutableHashMultisetMultimapBase(final MutableDictionary<K, MutableMultiset<V>> _delegate) : super(_delegate);
  
  MutableMultiset<V> _newValueContainer() =>
      new MutableMultiset.hash();
}

class _MutableSplayTreeMultisetMultimapBase<K,V> extends _AbstractMutableMultimap<K,V, MutableMultiset<V>> implements MutableMultisetMultimap<K,V> {      
  _MutableSplayTreeMultisetMultimapBase(final MutableDictionary<K, MutableMultiset<V>> _delegate) : super(_delegate);
  
  MutableMultiset<V> _newValueContainer() =>
      new MutableMultiset.splayTree();
}