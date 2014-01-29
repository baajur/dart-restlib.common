part of restlib.common.collections.immutable;

abstract class ImmutableDictionary<K,V> implements Dictionary<K,V>, ImmutableAssociative<K,V> {
  ImmutableDictionary<K,V> putAll(final Iterable<Pair<K, V>> other);
  
  ImmutableDictionary<K,V> put(final K key, final V value);
  
  ImmutableDictionary<K,V> putAllFromMap(final Map<K,V> map);
  
  ImmutableDictionary<K,V> putPair(final Pair<K,V> pair);
  
  ImmutableDictionary<K,V> removeAt(final K key);
  
  ImmutableDictionary<K,V> putIfAbsent(final K key, final V value);
}

abstract class _ImmutableDictionaryBase<K,V> 
    extends DictionaryBase<K,V> implements ImmutableDictionary<K,V> {
  const _ImmutableDictionaryBase();
  
  int get hashCode =>
      fold(0, (final int accumulator, final Pair<K,V> pair) => 
          accumulator + (pair.fst.hashCode ^ pair.snd.hashCode));
  
  bool operator ==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableDictionary) {
      if (this.length != other.length) {
        return false;
      }
      
      return every((final Pair<K,V> pair) => 
          other[pair.fst]
            .map((final V value) => 
                pair.snd == value)
            .orElse(false));      
    } else {
      return false;
    }
  }
      
  ImmutableDictionary<K,V> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  ImmutableDictionary<K,V> putIfAbsent(final K key, final V value) =>
      this[key]
        .map((final V value) => 
            this)
        .orCompute(() => 
            this.put(key, value));
}