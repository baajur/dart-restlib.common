part of restlib.common.collections;

abstract class PersistentSequenceMultimap<K,V> implements PersistentMultimap<K,V,PersistentSequence<V>> {
  static const PersistentSequenceMultimap EMPTY = 
      const _PersistentSequenceMultimapBase._internal(PersistentDictionary.EMPTY);
  
  factory PersistentSequenceMultimap.fromMap(final Map<K,V> map) {
    PersistentSequenceMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentSequenceMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) =>
    (pairs is _PersistentSequenceMultimapBase) ? pairs : EMPTY.putAll(pairs);
  
  PersistentDictionary<K, PersistentSequence<V>> get dictionary;
  
  PersistentSequenceMultimap<K,V> putAll(final Iterable<Pair<K, V>> other);
  
  PersistentSequenceMultimap<K,V> put(final K key, final V value);
  
  PersistentSequenceMultimap<K,V> removeKey(final K key);
}

class _PersistentSequenceMultimapBase<K,V> extends _AbstractPersistentMultimap<K,V,PersistentSequence<V>> implements PersistentSequenceMultimap<K,V> {    
  const _PersistentSequenceMultimapBase._internal(PersistentDictionary<K, PersistentSequence<V>> dictionary): super._internal(dictionary);
  
  PersistentSequence _emptyValueContainer() =>
      PersistentSequence.EMPTY;
  
  PersistentSequenceMultimap<K,V> put(final K key, final V value) =>
      new _PersistentSequenceMultimapBase._internal(
          dictionary.put(key, this[key].add(value)));
  
  PersistentSequenceMultimap<K,V> removeKey(final K key) =>
      new _PersistentSequenceMultimapBase._internal(
          dictionary.removeKey(key));
}