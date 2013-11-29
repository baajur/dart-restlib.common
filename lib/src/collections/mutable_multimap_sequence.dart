part of restlib.common.collections;

abstract class MutableSequenceMultimap<K, V> implements MutableMultimap<K, V, GrowableSequence<V>> {
  factory MutableSequenceMultimap.hash() =>
      new _MutableSequenceMultimapBase(new MutableDictionary.hash());
  
  factory MutableSequenceMultimap.splayTree() =>
      new _MutableSequenceMultimapBase(new MutableDictionary.splayTree());
}

class _MutableSequenceMultimapBase<K,V> extends _AbstractMutableMultimap<K,V, GrowableSequence<V>> implements MutableSequenceMultimap<K,V> {  
  _MutableSequenceMultimapBase(final MutableDictionary<K, GrowableSequence<V>> _delegate) : super(_delegate);
  
  GrowableSequence<V> _newValueContainer() =>
      new GrowableSequence();
}