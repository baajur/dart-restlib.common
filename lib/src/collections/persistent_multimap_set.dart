part of restlib.common.collections;

abstract class PersistentSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements PersistentMultimap<K,V,PersistentSet<V>> {
  static const PersistentSetMultimap EMPTY = 
      const _PersistentSetMultimapBase._internal(PersistentDictionary.EMPTY);
  
  factory PersistentSetMultimap.fromMap(final Map<K,V> map) {    
    PersistentSetMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentSetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) => 
      (pairs is PersistentSetMultimap) ? pairs : EMPTY.putAll(pairs);

  PersistentDictionary<K, PersistentSet<V>> get dictionary;
  
  PersistentSetMultimap<K,V> putAll(final Iterable<Pair<K, V>> other);
  
  PersistentSetMultimap<K,V> put(final K key, final V value);
  
  PersistentSetMultimap<K,V> removeAt(final K key);
}

class _PersistentSetMultimapBase<K,V> extends _AbstractPersistentMultimap<K,V,PersistentSet<V>> implements PersistentSetMultimap<K,V>{  
  const _PersistentSetMultimapBase._internal(final PersistentDictionary<K, PersistentSet<V>> dictionary) :
    super._internal(dictionary);
  
  PersistentSet _emptyValueContainer() =>
      PersistentSet.EMPTY;
  
  PersistentSetMultimap<K,V> put(final K key, final V value) =>
      new _PersistentSetMultimapBase._internal(
          dictionary.put(key, this[key].add(value)));
  
  PersistentSetMultimap<K,V> removeAt(final K key) =>
      new _PersistentSetMultimapBase._internal(
          dictionary.removeAt(key));
}