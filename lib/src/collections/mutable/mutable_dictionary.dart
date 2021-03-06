part of collections.mutable;

abstract class MutableDictionary<K,V> implements Dictionary<K,V>, MutableAssociative<K,V> {
  factory MutableDictionary.hash({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ? 
          new _MutableDictionaryBase._internal(
              pairs.fold(new HashMap(), (final HashMap<K,V> delegate, final Pair<K,V> pair) => 
                  delegate..[pair.e0] = pair.e1)) :
            new _MutableDictionaryBase._internal(new HashMap<K,V>());
  
  factory MutableDictionary.splayTree({final Iterable<Pair<K,V>> pairs}) =>
      (pairs != null) ? 
          new _MutableDictionaryBase._internal(
              pairs.fold(new SplayTreeMap(), (final SplayTreeMap<K,V> delegate, final Pair<K,V> pair) => 
                  delegate..[pair.e0] = pair.e1)) :
            new _MutableDictionaryBase._internal(new SplayTreeMap<K,V>());
  
  Option<V> removeAt(final K key);
}