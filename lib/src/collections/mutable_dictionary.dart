part of restlib.common.collections;

abstract class MutableDictionary<K,V> implements Dictionary<K,V> {
  factory MutableDictionary.hash({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ? 
          new _MutableMapDictionary._internal(
              pairs.fold(new HashMap(), (final HashMap<K,V> delegate, final Pair<K,V> pair) => 
                  delegate[pair.fst] = pair.snd)) :
            new _MutableMapDictionary._internal(new HashMap<K,V>());
  
  factory MutableDictionary.splayTree({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ? 
          new _MutableMapDictionary._internal(
              pairs.fold(new SplayTreeMap(), (final SplayTreeMap<K,V> delegate, final Pair<K,V> pair) => 
                  delegate[pair.fst] = pair.snd)) :
            new _MutableMapDictionary._internal(new SplayTreeMap<K,V>());
   
  void operator[]=(final K key, final V value);
  
  void addAll(final Iterable<Pair<K, V>> other);
  
  void put(final K key, final V value);
  
  bool remove(final K key);
}