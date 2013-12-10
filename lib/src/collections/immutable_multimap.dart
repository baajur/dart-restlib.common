part of restlib.common.collections;

abstract class ImmutableMultimap<K,V, I extends Iterable<V>> implements Multimap<K,V,I>, ImmutableAssociative<K,V> {
  ImmutableDictionary<K, I> get dictionary;
  
  ImmutableMultimap<K,V,I> insertAll(final Iterable<Pair<K, V>> other);
  
  ImmutableMultimap<K,V,I> insert(final K key, final V value);
  
  ImmutableMultimap<K,V,I> removeAt(final K key);
}

abstract class _ImmutableMultimapBase<K,V, I extends ImmutableCollection<V>> extends IterableBase<Pair<K,V>> implements ImmutableMultimap<K,V, I> {  
  const _ImmutableMultimapBase(); 
  
  int get hashCode => 
      dictionary.hashCode;
  
  bool get isEmpty => 
      dictionary.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      dictionary.expand((final Pair<K, I> pair) => 
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  Iterable<K> get keys =>
      dictionary.keys;
  
  Iterable<V> get values =>
      this.map((final Pair<K,V> pair) => 
          pair.snd);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableMultimap) {
      return this.dictionary == other.dictionary;
    } else {
      return false;
    }
  }
  
  bool containsKey(final K key) =>
      dictionary.containsKey(key);

  bool containsValue(final V value) => 
      keys.any((final K key) => 
          this[key].contains(value));
  
  ImmutableMultimap<K,V,I> insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
  String toString() => 
      dictionary.toString();
}
