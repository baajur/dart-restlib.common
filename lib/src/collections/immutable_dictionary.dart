part of restlib.common.collections;

abstract class ImmutableDictionary<K,V> implements Dictionary<K,V>, ImmutableAssociative<K,V> {
  static const ImmutableDictionary EMPTY = const _PersistentDictionaryBase._internal(0, null);
  
  factory ImmutableDictionary.fromMap(final Map<K,V> map) {
    ImmutableDictionary<K,V> result = EMPTY;
    map.forEach((final K k, final V v) => 
        result = result.insert(k, v));
    return result;
  }
  
  factory ImmutableDictionary.fromPairs(final Iterable<Pair<K,V>> pairs) => 
      (pairs is ImmutableDictionary) ? pairs : EMPTY.insertAll(pairs);
  
  ImmutableDictionary<K,V> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableDictionary<K,V> insert(final K key, final V value);
  
  ImmutableDictionary<K,V> insertPair(final Pair<K,V> pair);
  
  ImmutableDictionary<K,V> removeAt(final K key);
  
  ImmutableDictionary<K,V> putIfAbsent(final K key, final V value);
}

abstract class _ImmutableDictionaryBase<K,V> extends IterableBase<Pair<K,V>> implements ImmutableDictionary<K,V> {
  const _ImmutableDictionaryBase();
  
  int get hashCode =>
      fold(0, (final int accumulator, final Pair<K,V> pair) => 
          accumulator + (pair.fst.hashCode ^ pair.snd.hashCode));
  
  bool get isEmpty => length == 0;
  
  Iterable<K> get keys =>
      this.map((final Pair<K,V> pair) => 
          pair.fst);
  
  Iterable<V> get values =>
      this.map((final Pair<K,V> pair) => 
          pair.snd);
  
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
  
  Map<K,V> asMap() =>
      new _DictionaryAsMap(this);
  
  bool contains(final Object pair) {
    if (pair is Pair) {
      return this[pair.fst]
        .map((final V value) => 
            value == pair.snd)
        .orElse(false);
    } else {
      return false;
    }
  }
    
  bool containsKey(final K key) =>
      this[key] != Option.NONE;
  
  bool containsValue(final V value) => 
      this.any((final Pair<K,V> pair) => 
          pair.snd == value);
  
  ImmutableDictionary<K,V> insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
  ImmutableDictionary<K,V> putIfAbsent(final K key, final V value) =>
      this[key]
        .map((final V value) => 
            this)
        .orCompute(() => 
            this.insert(key, value));
  
  String toString() =>
      "{" + map((pair) => "${pair.fst} : ${pair.snd}").join(", ") + "}";
}