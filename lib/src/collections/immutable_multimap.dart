part of restlib.common.collections;

class ImmutableListMultimap<K,V> extends Object with IterableMixin<Pair<K,V>> implements Multimap<K,V> {
  static final ImmutableListMultimap EMPTY = new ImmutableListMultimap._internal(ImmutableMap.EMPTY);
  
  factory ImmutableListMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    return (new ImmutableListMultimapBuilder()..addAllPairs(pairs)).build();
  }
  
  factory ImmutableListMultimap.fromMap(final Map<K,V> map) {
    ImmutableListMultimapBuilder builder = new ImmutableListMultimapBuilder();
    map.forEach((k,v) => builder.add(k, v));
    return builder.build();
  }
  
  final ImmutableMap<K, ImmutableList<V>> _map;
  
  ImmutableListMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  bool get isEmpty => _map.isEmpty;
  
  bool get isNotEmpty => _map.isNotEmpty;
  
  Iterator<Pair<K,V>> get iterator => new _MultimapEntriesIterator(this);
  
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

class ImmutableListMultimapBuilder<K,V> {
  Map<K,List<V>> _builder;
  
  ImmutableListMultimapBuilder() :
    _builder = new Map();
  
  add(K key, V value) {
    if (_builder.containsKey(key)) {
      _builder[key].add(value);
    } else {
      _builder[key] = [value];
    }
  }
  
  addPair(Pair<K,V> pair) =>
      add(pair.fst, pair.snd);
  
  addAllPairs(Iterable<Pair<K,V>> pairs) =>
    pairs.forEach((pair) =>
        addPair(pair));
  
  ImmutableListMultimap<K,V> build() {
    Map<K, ImmutableList<V>> built = new Map();
    _builder.keys.forEach((key) => 
        built[key] = new ImmutableList.from(_builder[key]));
    return new ImmutableListMultimap._internal(new ImmutableMap._internal(built));
  }
}

class ImmutableSetMultimap<K,V> extends Object with IterableMixin<Pair<K,V>> implements Multimap<K,V> {
  static final ImmutableSetMultimap EMPTY = new ImmutableSetMultimap._internal(ImmutableMap.EMPTY);
  
  factory ImmutableSetMultimap.fromPairs(final Iterable<Pair<K,V>> pairs) {
    return (new ImmutableSetMultimapBuilder()..addAllPairs(pairs)).build();
  }
  
  factory ImmutableSetMultimap.fromMap(final Map<K,V> map) {
    ImmutableSetMultimapBuilder builder = new ImmutableSetMultimapBuilder();
    map.forEach((k,v) => builder.add(k, v));
    return builder.build();
  }
  
  final ImmutableMap<K, ImmutableSet<V>> _map;
  
  const ImmutableSetMultimap._internal(this._map);
  
  int get hashCode => _map.hashCode;
  
  bool get isEmpty => _map.isEmpty;
  
  bool get isNotEmpty => _map.isNotEmpty;
  
  Iterator<Pair<K,V>> get iterator => new _MultimapEntriesIterator(this);
  
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

class ImmutableSetMultimapBuilder<K,V> {
  Map<K,List<V>> _builder;
  
  ImmutableSetMultimapBuilder() :
    _builder = new Map();
  
  add(K key, V value) {
    if (_builder.containsKey(key)) {
      _builder[key].add(value);
    } else {
      _builder[key] = [value];
    }
  }
  
  addPair(Pair<K,V> pair) =>
      add(pair.fst, pair.snd);
  
  addAllPairs(Iterable<Pair<K,V>> pairs) =>
    pairs.forEach((pair) =>
        addPair(pair));
  
  ImmutableSetMultimap<K,V> build() {
    Map<K, ImmutableSet<V>> built = new Map();
    _builder.keys.forEach((key) => 
        built[key] = new ImmutableSet.from(_builder[key]));
    return new ImmutableSetMultimap._internal(new ImmutableMap._internal(built));
  }
}

class _MultimapEntriesIterator<K,V> implements Iterator<Pair<K,V>> {
  final Iterator<Pair<K,Iterable<V>>> _multimapItr;
  
  K _currentKey = null;
  Iterator<V> _currentValuesItr = null;
  
  Pair<K,V> _current = null;
  
  _MultimapEntriesIterator(Multimap<K,V> multimap) :
    _multimapItr = multimap.asDictionary().iterator;
  
  Pair<K,V> get current => _current;
  
  bool moveNext() { 

  }
}