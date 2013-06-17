part of restlib.common.collections;

class ImmutableListMultimap<K,V> implements Associative<K,V> {
static const EMPTY = new ImmutableListMultimap._internal(ImmutableMap.EMPTY);
  
  final ImmutableMap<K, ImmutableList<V>> _map;
  
  const ImmutableListMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  Iterable<Pair<K,V>> get entries;
  
  Iterable<K> get keys => _map.keys;
  
  ImmutableList<V> operator[](final K key) =>
      _map[key].orElse(ImmutableList.EMPTY);
  
  bool operator==(final object) {
    if (identical(this,object)) {
      return true;
    } else if (object is ImmutableListMultimap) {
      
    } else {
      return false;
    }
  }
}

class ImmutableSetMultimap<K,V> implements Associative<K,V> {
  
}