part of restlib.common.collections;

abstract class _MultimapBase<K,V,I extends Iterable<V>> 
    extends IterableBase<Pair<K,V>> implements Multimap<K,V,I> {
  const _MultimapBase();
  
  bool get isEmpty => 
      dictionary.isEmpty;
  
  I get _emptyValueContainer;
  
  Iterator<Pair<K,V>> get iterator =>
      dictionary.expand((final Pair<K, I> pair) => 
          pair.snd.map((final V value) =>
              new Pair(pair.fst, value))).iterator;
  
  Iterable<K> get keys =>
      dictionary.keys;
  
  Iterable<V> get values =>
      this.map((final Pair<K,V> pair) => 
          pair.snd);
  
  I operator[](final K key) =>
      dictionary[key]
        .map((final I value) => 
            value)
        .orElse(_emptyValueContainer);
  
  bool contains(final Object pair) {
    if (pair is Pair) {
      return dictionary[pair.fst]
        .map((final I values) =>
            values.contains(pair.snd))
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
  
  Multimap<K, dynamic, dynamic> mapValues(mapFunc(V value)) =>
      new _MappedMultimap(this, mapFunc);
  
  String toString() => 
      dictionary.toString();
}
    
class _MappedMultimap extends _MultimapBase {
  final Dictionary<dynamic, Iterable> dictionary;
  final Option _emptyValueContainer = Option.NONE;
  final mapFunc;
  
  _MappedMultimap(final Multimap delegate, final mapFunc) :
    dictionary = delegate.dictionary.mapValues((final Iterable itr) => 
        itr.map(mapFunc)),
    this.mapFunc = mapFunc;
}
    