part of restlib.common.collections;

class PersistentListMultimap<K,V> extends IterableBase<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentListMultimap EMPTY = 
      const PersistentListMultimap._internal(PersistentDictionary.EMPTY);
  
  factory PersistentListMultimap.fromMap(final Map<K,V> map) {
    PersistentListMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentListMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    return (pairs is PersistentListMultimap) ? pairs :
      pairs.fold(EMPTY, (final PersistentListMultimap<K,V> accumulator, final Pair<K,V> pair) => 
          accumulator.put(pair.fst, pair.snd));
  }
  
  final PersistentDictionary<K, PersistentSequence<V>> dictionary;
  
  const PersistentListMultimap._internal(this.dictionary);
  
  int get hashCode => 
      dictionary.hashCode;
  
  bool get isEmpty => 
      dictionary.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      dictionary.expand((final Pair<K, PersistentSequence<V>> pair) => 
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentListMultimap) {
      return this.dictionary == other.dictionary;
    } else {
      return false;
    }
  }
  
  PersistentSequence<V> operator[](final K key) =>
      dictionary[key]
        .map((final V value) => 
            value)
        .orElse(PersistentSequence.EMPTY);
  
  bool containsKey(final K key) =>
      dictionary.containsKey(key);
  
  PersistentListMultimap<K,V> put(final K key, final V value) =>
      new PersistentListMultimap._internal(
          dictionary.put(key, this[key].add(value)));
  
  PersistentListMultimap<K,V> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  PersistentListMultimap<K,V> putAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final PersistentListMultimap<K,V> accumulator, final Pair<K,V> pair) =>
          accumulator.putPair(pair));
  
  PersistentListMultimap<K,V> remove(final K key) =>
      new PersistentListMultimap._internal(
          dictionary.remove(key));
  
  String toString() => 
      dictionary.toString();
}

class PersistentSetMultimap<K,V> extends IterableBase<Pair<K,V>> implements Multimap<K,V> {
  static const PersistentSetMultimap EMPTY = 
      const PersistentSetMultimap._internal(PersistentDictionary.EMPTY);
  
  factory PersistentSetMultimap.fromMap(final Map<K,V> map) {    
    PersistentSetMultimap<K,V> retval = EMPTY;
    map.forEach((final K k, final V v) => 
        retval = retval.put(k, v));
    return retval;
  }
  
  factory PersistentSetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    return (pairs is PersistentSetMultimap) ? pairs :
      pairs.fold(EMPTY, (final PersistentSetMultimap<K,V> accumulator, final Pair<K,V> pair) => 
          accumulator.put(pair.fst, pair.snd));
  }
  
  final PersistentDictionary<K, PersistentSet<V>> dictionary;
  
  const PersistentSetMultimap._internal(this.dictionary);
  
  int get hashCode => dictionary.hashCode;
  
  bool get isEmpty => dictionary.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      dictionary.expand((final Pair<K, PersistentSet<V>> pair) => 
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is PersistentSetMultimap) {
      return this.dictionary == other.dictionary;
    } else {
      return false;
    }
  }
  
  PersistentSet<V> operator[](final K key) =>
      dictionary[key]
        .map((final V value) => 
            value)
        .orElse(PersistentSet.EMPTY);
  
  bool containsKey(final K key) =>
      dictionary.containsKey(key);
  
  PersistentSetMultimap<K,V> put(final K key, final V value) =>
      new PersistentSetMultimap._internal(
          dictionary.put(key, this[key].add(value)));
  
  PersistentSetMultimap<K,V> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  PersistentSetMultimap<K,V> putAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final PersistentSetMultimap<K,V> accumulator, final Pair<K,V> pair) =>
          accumulator.putPair(pair));
  
  PersistentSetMultimap<K,V> remove(final K key) =>
      new PersistentSetMultimap._internal(
          dictionary.remove(key));
  
  String toString() => dictionary.toString();
}