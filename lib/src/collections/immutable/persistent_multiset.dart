part of collections.immutable;

class _PersistentMultisetBase<E> 
    extends _ImmutableMultisetBase<E> {
      
  static const ImmutableMultiset EMPTY = const _PersistentMultisetBase(EMPTY_DICTIONARY);    
  
  final ImmutableDictionary<E,int> _delegate;
  
  const _PersistentMultisetBase(this._delegate);
  
  Iterable<E> get elements =>
      _delegate.map((final Pair<E,int> pair) => pair.e0);
  
  Dictionary<E, int> get entries =>
      _delegate;
  
  Iterator<E> get iterator => 
      _delegate.expand((final Pair<E, int> pair) =>
          new List.filled(pair.e1, pair.e0)).iterator;
  
  int count(final E element) => 
      _delegate[element].orElse(0);
  
  ImmutableMultiset<E> add(final E element) =>
      _delegate[element]
        .map((final int i) =>
          new _PersistentMultisetBase(_delegate.put(element, i + 1)))
        .orElse(new _PersistentMultisetBase(_delegate.put(element, 1)));
  
  ImmutableMultiset<E> addAll(final Iterable<E> elements) {
    if (identical(this, EMPTY) && (elements is _PersistentMultisetBase)) {
      return elements;
    } else {
      return elements.fold(this, 
          (final ImmutableMultiset<E> accumulator,  final E element) => 
              accumulator.add(element));
    }
  }
  
  bool contains(final E element) =>
      _delegate.containsKey(element);
      
  ImmutableMultiset<E> remove (final E element) => 
      _delegate[element]
        .map((final int i) =>
            (i > 1) ? 
                new _PersistentMultisetBase(_delegate.put(element, i - 1)) : 
                  new _PersistentMultisetBase(_delegate.removeAt(element)))
        .orElse(this);
  
  ImmutableMultiset<E> removeAll(final E element) =>
      new _PersistentMultisetBase(_delegate.removeAt(element));
}