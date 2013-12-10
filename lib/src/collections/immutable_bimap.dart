part of restlib.common.collections;

abstract class ImmutableBiMap<K,V> implements BiMap<K,V>, ImmutableDictionary<K,V> {
  // FIXME: Ideally this would const, but dart doesn't yet allow using mixins with const
  // see: https://code.google.com/p/dart/issues/detail?id=9745   
  static final ImmutableBiMap EMPTY = _PersistentBiMapBase.EMPTY;
  
  factory ImmutableBiMap.fromMap(final Map<K,V> map) {
    ImmutableBiMap<K,V> result = EMPTY;
    map.forEach((k,v) => result = result.insert(k, v));
    return result;
  }
  
  factory ImmutableBiMap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    if (pairs is ImmutableBiMap) {
      return pairs;
    } else if (pairs.isEmpty) {
      return EMPTY;
    } else { 
      return pairs.fold(EMPTY, 
          (final ImmutableDictionary<K,V> previousValue, final Pair<K,V> element) 
            => previousValue.insert(element.fst, element.snd));
    }
  }
  
  ImmutableBiMap<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableBiMap<K,V> insert(final K key, final V value);
  
  ImmutableBiMap<K,V> insertPair(final Pair<K,V> pair);
  
  ImmutableBiMap<K,V> removeAt(final K key);
  
  ImmutableBiMap<K,V> putIfAbsent(final K key, final V value);
}

abstract class _ImmutableBiMapBase<K,V> extends _ImmutableDictionaryBase<K,V> implements ImmutableBiMap<K,V> {
  const _ImmutableBiMapBase();
}