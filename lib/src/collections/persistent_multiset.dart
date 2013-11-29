part of restlib.common.collections;

abstract class PersistentMultiset<E> implements PersistentCollection<E>, Multiset<E> {
  static const PersistentMultiset EMPTY = const _PersistentMultisetBase(PersistentDictionary.EMPTY);
  
  PersistentMultiset<E> add(E value);
  
  PersistentMultiset<E> addAll(Iterable<E> elements);  
  
  PersistentMultiset<E> remove(E element);
  
  PersistentMultiset<E> removeAll(final E element);
}


class _PersistentMultisetBase<E> extends IterableBase<E> implements PersistentMultiset<E> {
  final PersistentDictionary<E,int> _delegate;
  
  const _PersistentMultisetBase(this._delegate);
  
  Iterator<E> get iterator => 
      _delegate.expand((final Pair<E, int> pair) =>
          new List.filled(pair.snd, pair.fst)).iterator;
  
  int count(final E element) => 
      _delegate[element].orElse(0);
  
  PersistentMultiset<E> add(final E element) =>
      _delegate[element]
        .map((final int i) =>
          new _PersistentMultisetBase(_delegate.put(element, i + 1)))
        .orElse(new _PersistentMultisetBase(_delegate.put(element, 1)));
  
  PersistentMultiset<E> addAll(final Iterable<E> elements) =>
      elements.fold(this, 
          (final PersistentMultiset<E> accumulator, final E element) => 
              accumulator.add(element));
  
  bool contains(final E element) =>
      _delegate.containsKey(element);
      
  PersistentMultiset<E> remove (final E element) => 
      _delegate[element]
        .map((final int i) =>
            (i > 1) ? 
                new _PersistentMultisetBase(_delegate.put(element, i - 1)) : 
                  new _PersistentMultisetBase(_delegate.remove(element)))
        .orElse(this);
  
  PersistentMultiset<E> removeAll(final E element) =>
      new _PersistentMultisetBase(_delegate.remove(element));
}