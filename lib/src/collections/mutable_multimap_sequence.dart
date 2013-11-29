part of restlib.common.collections;

abstract class MutableSequenceMultimap<K, V> implements MutableMultimap<K, V, GrowableSequence<V>> {
  factory MutableSequenceMultimap.hash() =>
      new _AbstractMutableSequenceMultimap(new MutableDictionary.hash());
  
  factory MutableSequenceMultimap.splayTree() =>
      new _AbstractMutableSequenceMultimap(new MutableDictionary.splayTree());
}

class _AbstractMutableSequenceMultimap<K,V> extends _AbstractMutableMultimap<K,V, GrowableSequence<V>> implements MutableSequenceMultimap<K,V> {  
  _AbstractMutableSequenceMultimap(final MutableDictionary<K, GrowableSequence<V>> _delegate) : super(_delegate);
  
  GrowableSequence<V> operator[](final K key) =>
      _delegate[key]
        .map((final GrowableSequence<V> seq) => seq)
        .orCompute(() {
          final GrowableSequence<V> value = new GrowableSequence();
          _delegate.put(key, value);
          return value;
        });

  void put(final K key, final V value) => 
      _delegate.put(key, 
          _delegate[key]
            .map((final GrowableSequence<V> seq) => 
                seq.add(value))
            .orCompute(() =>  
                new GrowableSequence()..add(value)));
}