part of restlib.common.collections;

class CopyOnWriteListMultimap<K,V> implements ImmutableMultimap<K,V> { 
  static const EMPTY = new CopyOnWriteListMultimap._internal(CopyOnWriteMap.EMPTY);
  
  final CopyOnWriteMap<K, CopyOnWriteList<V>> _map;
  
  const CopyOnWriteListMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  Iterable<Pair<K,V>> get entries;
  
  Iterable<K> get keys => _map.keys;
  
  CopyOnWriteList<V> operator[](final K key) =>
      _map[key].orElse(CopyOnWriteList.EMPTY);
  
  bool operator==(final object) {
    if (identical(this,object)) {
      return true;
    } else if (object is ImmutableListMultimap) {
      
    } else {
      return false;
    }
  }
  
  CopyOnWriteListMultimap<K,V> insert(final K key, final V value) =>
      new CopyOnWriteListMultimap._internal(
          _map.insert(
              key, 
              _map[key]
                .map((final CopyOnWriteList<V> list) => list.add(value))
                .orCompute(() => CopyOnWriteList.EMPTY.add(value))));
  
  CopyOnWriteListMultimap<K,V> insertPair(final Pair<K,V> pair) =>
      insert(pair.fst, pair.snd);
  
  CopyOnWriteListMultimap<K,V> insertAll(Iterable<Pair<K,V>> pairs);
  
  CopyOnWriteListMultimap<K,V> insertValues(K key, Iterable<V> values);
}