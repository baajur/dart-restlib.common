part of restlib.common.collections;


class ImmutableListMultimapBuilder<K,V> {
  
}

class ImmutableListMultimap<K,V> implements Multimap<K,V> {
  static const ImmutableListMultimap EMPTY = new ImmutableListMultimap._internal(ImmutableMap.EMPTY);
  
  final ImmutableMap<K, ImmutableList<V>> _map;
  
  const ImmutableListMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  Iterable<Pair<K,V>> get entries => new _MultimapEntriesIterable(this);
  
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
  
  Dictionary<K, ImmutableList<V>> asDictionary() => _map;
}

class ImmutableSetMultimap<K,V> implements Multimap<K,V> {
  static const ImmutableSetMultimap EMPTY = new ImmutableSetMultimap._internal(ImmutableMap.EMPTY);
  
  final ImmutableMap<K, ImmutableSet<V>> _map;
  
  const ImmutableSetMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  Iterable<Pair<K,V>> get entries => new _MultimapEntriesIterable(this);
  
  Iterable<K> get keys => _map.keys;
  
  ImmutableList<V> operator[](final K key) =>
      _map[key].orElse(ImmutableList.EMPTY);
  
  bool operator==(final object) {
    if (identical(this,object)) {
      return true;
    } else if (object is ImmutableSetMultimap) {
      
    } else {
      return false;
    }
  }
  
  Dictionary<K, ImmutableSet<V>> asDictionary() => _map;
}

class _MultimapEntriesIterable<K,V> extends Object with IterableMixin<Pair<K,V>> {
  final Multimap<K,V> _multimap;
  
  _MultimapEntriesIterable(this._multimap);
  
  Iterator<Pair<K,V>> get iterator => new _MultimapEntriesIterator(_multimap); 
}

class _MultimapEntriesIterator<K,V> implements Iterator<Pair<K,V>> {
  final Iterator<Pair<K,Iterable<V>>> _multimapItr;
  
  K currentKey = null;
  Iterator<V> _currentValuesItr = null;
  
  Pair<K,V> _current = null;
  
  _MultimapEntriesIterator(Multimap<K,V> multimap) :
    _multimapItr = multimap.asDictionary().iterator;
  
  Pair<K,V> get current => _current;
  
  bool moveNext() {
    if (currentKey == null) {
      
    }
    
    if (currentValuesItr.moveNext()) {
      
    } else {
      
    }
  }
}