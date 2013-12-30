part of restlib.common.collections;

abstract class MutableMultiset<E> implements Multiset<E>, MutableCollection<E> {
  factory MutableMultiset.hash() =>
      new _MutableMultisetBase(new MutableDictionary.hash());
  
  factory MutableMultiset.splayTree() =>
      new _MutableMultisetBase(new MutableDictionary.splayTree());
  
  Iterable<E> removeAll(final E element);
}

class _MutableMultisetBase<E> extends IterableBase<E> implements MutableMultiset<E> {
  final MutableDictionary<E,int> _delegate;
  
  _MutableMultisetBase(this._delegate);
  
  Iterable<E> get elements =>
      _delegate.map((final Pair<E, int> pair) => pair.fst);
  
  Dictionary<E, int> get entries =>
      _delegate;
  
  Iterator<E> get iterator => 
      _delegate.expand((final Pair<E, int> pair) =>
          new List.filled(pair.snd, pair.fst)).iterator;
  
  int count(final E element) => 
      _delegate[element].orElse(0);
  
  void add(final E element) =>
      _delegate[element]
        .map((final int i) {
          _delegate.insert(element, i + 1);
        }).orCompute(() {
          _delegate.insert(element, 1);
        });
  
  void addAll(final Iterable<E> elements) =>
      elements.forEach((final E element) => 
          add(element));
  
  void clear() =>
      _delegate.clear();
  
  bool contains(final E element) =>
      _delegate.containsKey(element);
      
  Option<E> remove (final E element) => 
      _delegate[element]
        .map((final int i) {
          if (i > 1) {
            _delegate.insert(element, i - 1);
          } else {
            _delegate.removeAt(element);
          }
          return new Option(element);
        }).orElse(Option.NONE);
  
  Iterable<E> removeAll(final E element) {
    _delegate[element]
      .map((final int i) => 
          new List.filled(i, element))
      .orElse(EMPTY_LIST);
  }
}