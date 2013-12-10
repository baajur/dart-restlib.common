part of restlib.common.collections;

class OptionArray<E> 
    extends IterableBase<E>
    implements Associative<int, E>, Iterable<E> {
  final Array<Option<E>> _delegate;
  
  const OptionArray.wrap(final Array<Option<E>> delegate) :
    this._delegate = delegate;
  
  OptionArray.ofSize(int size) :
    _delegate = new Array.wrap(new List.filled(size, Option.NONE));
  
  Iterator<E> get iterator =>
      _delegate.map((final Option<E> e) =>
          e.nullableValue).iterator;
  
  Iterable<int> get keys =>
      new List.generate(length, (i) => i);
  
  int get length => _delegate.length;
  
  Iterable<E> get values => 
      this;
  
  Option<E> operator [](int key) =>
      (key < length) ? 
          _delegate[key]:
            Option.NONE;
  
  void operator []=(int key, E value) {
    _delegate[key] = new Option(value);
  }
  
  bool containsKey(int key) =>
    (key >= 0 ) && (key < length);  
  
  bool containsValue(E value) =>
      _delegate.contains(new Option(value));
}