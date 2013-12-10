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
  final Multiset<E> delegate;
  
  _CopyOnWriteMultiset(this.delegate);
  
  Iterator<E> get iterator =>
      delegate.iterator;
  
  int count(final E object) =>
      delegate.count(object);
  
  ImmutableMultiset<E> add(final E object) =>
      new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(this)
            ..add(object));

  ImmutableMultiset<E> addAll(final Iterable<E> elements) =>
      new _CopyOnWriteMultiset(
          new MutableMultiset.hash()
            ..addAll(this)
            ..addAll(elements));
  
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