part of collections.internal;

abstract class DictionaryBase<K,V> extends IterableBase<Pair<K,V>> implements Dictionary<K,V> {
  const DictionaryBase();

  bool get isEmpty => length == 0;

  Iterable<K> get keys =>
      this.map((final Pair<K,V> pair) =>
          pair.e0);

  Iterable<V> get values =>
      this.map((final Pair<K,V> pair) =>
          pair.e1);

  Option<V> call(final K key) =>
      this[key];

  bool contains(final Object pair) {
    if (pair is Pair) {
      return this[pair.e0]
        .map((final V value) =>
            value == pair.e1)
        .orElse(false);
    } else {
      return false;
    }
  }

  bool containsKey(final K key) =>
      this[key] != Option.NONE;

  bool containsValue(final V value) =>
      this.any((final Pair<K,V> pair) =>
          pair.e1 == value);

  Dictionary<K,V> filterKeys(bool filterFunc(K key)) =>
      new _KeyFilteredDictionary(this, filterFunc);

  Dictionary<K, dynamic> mapValues(mapFunc(V value)) =>
      new _MappedDictionary(this, mapFunc);

  Map<K,V> asMap() =>
      new _DictionaryAsMap(this);

  String toString() =>
      "{" + map((pair) => "${pair.e0} : ${pair.e1}").join(", ") + "}";
}

class _MappedDictionary extends DictionaryBase implements Forwarder {
  final Dictionary delegate;
  final mapFunc;

  _MappedDictionary(this.delegate, this.mapFunc);

  Iterator<Pair> get iterator =>
      delegate.map((final Pair pair) =>
          new Pair(pair.e0, mapFunc(pair.e1))).iterator;

  int get length =>
      delegate.length;

  Option operator[](final key) =>
      delegate[key].map(mapFunc);
}

class _DictionaryAsMap<K,V> implements Forwarder, Map<K,V> {
  final Dictionary<K,V> delegate;

  _DictionaryAsMap(this.delegate);

  bool get isEmpty =>
      delegate.isEmpty;

  bool get isNotEmpty =>
      delegate.isNotEmpty;

  Iterable<K> get keys =>
      delegate.keys;

  int get length =>
      delegate.length;

  Iterable<V> get values =>
      delegate.values;

  V operator [](Object key) =>
      delegate[key].map((e) => e).orElse(null);

  void operator []=(K key, V value) =>
      throw new UnsupportedError("Map is read only");

  void addAll(Map<K, V> other) =>
      throw new UnsupportedError("Map is read only");

  void clear() =>
      throw new UnsupportedError("Map is read only");

  bool containsKey(Object key) =>
      delegate.containsKey(key);

  bool containsValue(Object value) =>
      delegate.contains(value);

  void forEach(void f(K key, V value)) =>
      delegate.forEach((final Pair<K,V> pair) => f(pair.e0, pair.e1));

  V putIfAbsent(K key, V ifAbsent())  =>
      throw new UnsupportedError("Map is read only");

  V remove(Object key) =>
      throw new UnsupportedError("Map is read only");

  String toString() =>
      delegate.toString();
}

typedef bool _KeyFilterFunc(dynamic key);
class _KeyFilteredDictionary<K,V>
    extends DictionaryBase<K,V> {
  final Dictionary<K,V> delegate;
  final _KeyFilterFunc keyFilterFunc;

  _KeyFilteredDictionary(this.delegate, this.keyFilterFunc);

  Iterator<Pair<K,V>> get iterator =>
      delegate.where((final Pair<K,V> pair) => keyFilterFunc(pair.e0)).iterator;

  Iterable<K> get keys =>
      delegate.keys.where((keyFilterFunc));

  Iterable<V> get values =>
      delegate.where((final Pair<K,V> pair) => keyFilterFunc(pair.e0)).map((final Pair<K, V> pair) => pair.e1);

  Option<V> operator[](K key) {
    if (keyFilterFunc(key)) {
      return delegate(key);
    } else {
      return Option.NONE;
    }
  }

  Option<V> call(K key) =>
      this[key];

  bool containsKey(K key) =>
      keyFilterFunc(key) ? delegate.contains(key) : false;

  bool containsValue(V value) =>
      values.contains(value);
}

class MapAsDictionary<K,V> extends DictionaryBase<K,V> {
  final Map<K,V> _delegate;

  const MapAsDictionary(this._delegate);

  Iterator<Pair<K,V>> get iterator =>
      _delegate.keys.map((final K key) =>
          new Pair(key, _delegate[key])).iterator;

  Iterable<K> get keys =>
      _delegate.keys;

  int get length =>
      _delegate.length;

  Iterable<V> get values =>
      _delegate.values;

  Option<V> operator[](final K key) =>
      new Option(_delegate[key]);

  Map<K,V> asMap() =>
      _delegate;

  bool containsKey(Object key) =>
      _delegate.containsKey(key);

  bool containsValue(Object value) =>
      _delegate.containsValue(value);
}