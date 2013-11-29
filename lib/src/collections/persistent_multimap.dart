part of restlib.common.collections;

abstract class PersistentMultimap<K,V, I extends Iterable<V>> implements Multimap<K,V,I>, PersistentAssociative<K,V> {
  PersistentDictionary<K, I> get dictionary;
  
  PersistentMultimap<K,V,I> putAll(final Iterable<Pair<K, V>> other);
  
  PersistentMultimap<K,V,I> put(final K key, final V value);
  
  PersistentMultimap<K,V,I> removeKey(final K key);
}

abstract class _AbstractPersistentMultimap<K,V, I extends PersistentCollection<V>> extends IterableBase<Pair<K,V>> implements PersistentMultimap<K,V, I> {
  final PersistentDictionary<K, I> dictionary;
  
  const _AbstractPersistentMultimap._internal(this.dictionary); 
  
  int get hashCode => 
      dictionary.hashCode;
  
  bool get isEmpty => 
      dictionary.isEmpty;
  
  Iterator<Pair<K,V>> get iterator =>
      dictionary.expand((final Pair<K, I> pair) => 
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is _AbstractPersistentMultimap) {
      return this.dictionary == other.dictionary;
    } else if (other is PersistentMultimap) {
      // FIXME:
      return false;
    } else {
      return false;
    }
  }
  
  I operator[](final K key) =>
      dictionary[key]
        .map((final I value) => 
            value)
        .orElse(_emptyValueContainer());
  
  I _emptyValueContainer();
  
  bool containsKey(final K key) =>
      dictionary.containsKey(key);
  
  PersistentMultimap<K,V,I> putPair(final Pair<K,V> pair) =>
      put(pair.fst, pair.snd);
  
  PersistentMultimap<K,V,I> putAll(final Iterable<Pair<K,V>> pairs) =>
      pairs.fold(this, (final PersistentMultimap<K,V,I> accumulator, final Pair<K,V> pair) =>
          accumulator.putPair(pair));
  
  String toString() => 
      dictionary.toString();
}