part of  collections.internal;

abstract class MultimapBase<K,V,I extends Iterable<V>> 
    extends IterableBase<Pair<K,V>> implements Multimap<K,V,I> {
  const MultimapBase();
  
  bool get isEmpty => 
      dictionary.isEmpty;
  
  I get emptyValueContainer;
  
  Iterator<Pair<K,V>> get iterator =>
      dictionary.expand((final Pair<K, I> pair) => 
          pair.e1.map((final V value) =>
              new Pair(pair.e0, value))).iterator;
  
  Iterable<K> get keys =>
      dictionary.keys;
  
  Iterable<V> get values =>
      this.map((final Pair<K,V> pair) => 
          pair.e1);
  
  I operator[](final K key) =>
      dictionary[key]
        .map((final I value) => 
            value)
        .orElse(emptyValueContainer);
  
  I call(final K key) =>
      this[key];
  
  bool contains(final Object pair) {
    if (pair is Pair) {
      return dictionary[pair.e0]
        .map((final I values) =>
            values.contains(pair.e1))
        .orElse(false);
    } else {
      return false;
    }
  }
  
  bool containsKey(final K key) =>
      dictionary.containsKey(key);

  bool containsValue(final V value) => 
      keys.any((final K key) => 
          this[key].contains(value));  
  
  Multimap<K,V,I> filterKeys(bool filterFunc(K key)) =>
      new _KeyFilteredMultimap(this.dictionary, filterFunc);
  
  Multimap<K, dynamic, dynamic> mapValues(mapFunc(V value)) =>
      new _MappedMultimap(this, mapFunc);
  
  String toString() => 
      dictionary.toString();
}
    
class _MappedMultimap extends MultimapBase {
  final Dictionary<dynamic, Iterable> dictionary;
  final Option emptyValueContainer = Option.NONE;
  
  _MappedMultimap(final Multimap delegate, final mapFunc) :
    dictionary = delegate.dictionary.mapValues((final Iterable itr) => 
        itr.map(mapFunc));
}

class _KeyFilteredMultimap<K,V,I extends Iterable<V>> extends MultimapBase<K,V,I> {
  final Dictionary<K,I> dictionary;
  final Option emptyValueContainer = Option.NONE;
  
  _KeyFilteredMultimap(final Dictionary<K,I> delegate, final _KeyFilterFunc keyFilterFunc) :
    this.dictionary = delegate.filterKeys(keyFilterFunc);
}


    