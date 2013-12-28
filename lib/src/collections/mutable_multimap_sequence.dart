part of restlib.common.collections;

abstract class MutableSequenceMultimap<K, V> implements MutableMultimap<K, V, Sequence<V>>, SequenceMultimap<K,V> {
  factory MutableSequenceMultimap.hash() =>
      new _MutableSequenceMultimapBase(new MutableDictionary.hash());
  
  factory MutableSequenceMultimap.splayTree() =>
      new _MutableSequenceMultimapBase(new MutableDictionary.splayTree());
}

class _MutableSequenceMultimapBase<K,V> extends _AbstractMutableMultimap<K,V, Sequence<V>> implements MutableSequenceMultimap<K,V> {  
  _MutableSequenceMultimapBase(final MutableDictionary<K, GrowableSequence<V>> _delegate) : super(_delegate);
  
  Sequence<V> get _emptyValueContainer =>
      Persistent.EMPTY_SEQUENCE;
  
  GrowableSequence<V> _newValueContainer() =>
      new GrowableSequence();
}