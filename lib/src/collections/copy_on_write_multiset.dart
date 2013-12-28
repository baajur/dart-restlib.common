part of restlib.common.collections;

class CopyOnWriteMultisetBuilder<E> {
  final MutableMultiset<E> _set = new MutableMultiset.hash();
  
  void add(final E element) =>
      _set.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _set.addAll(elements);
  
  ImmutableMultiset<E> build() => 
      new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(_set));
}

class _CopyOnWriteMultiset<E> 
    extends _ImmutableMultisetBase<E>
    implements CopyOnWrite {
  static final _CopyOnWriteMultiset EMPTY = new _CopyOnWriteMultiset(new MutableMultiset.hash());     
      
  final MutableMultiset<E> delegate;
  
  _CopyOnWriteMultiset(this.delegate);
  
  Iterable<E> get elements =>
      delegate.elements;
  
  Dictionary<E, int> get entries =>
      delegate.entries;
  
  Iterator<E> get iterator =>
      delegate.iterator;
  
  int count(final E object) =>
      delegate.count(object);
  
  ImmutableMultiset<E> add(final E object) =>
      new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(this)
            ..add(object));

  ImmutableMultiset<E> addAll(final Iterable<E> elements) {
    if (this.isEmpty && (elements is _CopyOnWriteMultiset)) {
      return elements;
    } else {
      return new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(this)
            ..addAll(elements));
    }
  }
  
  ImmutableMultiset<E> remove(final E object) =>
      new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(this)
            ..remove(object));
  
  ImmutableMultiset<E> removeAll(final E object) =>
      new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(this)
            ..removeAll(object));
}