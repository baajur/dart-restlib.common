part of restlib.common.collections;

abstract class PersistentMultisetMultimap<K,V> extends IterableBase<Pair<K,V>> implements PersistentMultimap<K,V,PersistentMultiset<V>> {
  static const PersistentMultisetMultimap EMPTY = 
      const _PersistentMultisetMultimapBase._internal(PersistentDictionary.EMPTY);
  
  factory PersistentMultisetMultimap.fromMap(final Map<K,V> map) {    
    PersistentMultisetMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentMultisetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) => 
      (pairs is PersistentMultisetMultimap) ? pairs : EMPTY.putAll(pairs);

  PersistentDictionary<K, PersistentMultiset<V>> get dictionary;
  
  PersistentMultisetMultimap<K,V> putAll(final Iterable<Pair<K, V>> other);
  
  PersistentMultisetMultimap<K,V> put(final K key, final V value);
  
  PersistentMultisetMultimap<K,V> removeKey(final K key);
}

class _PersistentMultisetMultimapBase<K,V> extends _AbstractPersistentMultimap<K,V,PersistentMultiset<V>> implements PersistentMultisetMultimap<K,V>{  
  const _PersistentMultisetMultimapBase._internal(final PersistentDictionary<K, PersistentMultiset<V>> dictionary) :
    super._internal(dictionary);
  
  PersistentMultiset _emptyValueContainer() =>
      PersistentMultiset.EMPTY;
  
  PersistentMultisetMultimap<K,V> put(final K key, final V value) =>
      new _PersistentMultisetMultimapBase._internal(
          dictionary.put(key, this[key].add(value)));
  
  PersistentMultisetMultimap<K,V> removeKey(final K key) =>
      new _PersistentMultisetMultimapBase._internal(
          dictionary.removeKey(key));
}