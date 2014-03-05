part of collections.immutable;

abstract class ImmutableDictionary<K,V> implements Dictionary<K,V>, ImmutableAssociative<K,V> {
  Option<V> call(K key);
  
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
          accumulator + (pair.e0.hashCode ^ pair.e1.hashCode));
  
  bool operator ==(final other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableDictionary) {
      if (this.length != other.length) {
        return false;
      }
      
      return every((final Pair<K,V> pair) => 
          other[pair.e0]
            .map((final V value) => 
                pair.e1 == value)
            .orElse(false));      
    } else {
      return false;
    }
  }
  
  ImmutableDictionary<K,V> putAll(final Iterable<Pair<K, V>> pairs) {
    if (this.isEmpty && pairs is ImmutableDictionary) {
      return pairs;
    } else {
      return pairs.fold(this, 
          (final ImmutableDictionary accumulator, final Pair<K,V> element) => 
              accumulator.putIfAbsent(element.e0, element.e1));
    }
  }   
  
  ImmutableDictionary<K,V> putAllFromMap(final Map<K,V> map) {
    ImmutableDictionary<K,V> result = this;
    map.forEach((k,v) => 
        result = result.put(k, v));
    return result;
  }
      
  ImmutableDictionary<K,V> putPair(final Pair<K,V> pair) =>
      put(pair.e0, pair.e1);
  
  ImmutableDictionary<K,V> putIfAbsent(final K key, final V value) =>
      this[key]
        .map((final V value) => 
            this)
        .orCompute(() => 
            this.put(key, value));
}