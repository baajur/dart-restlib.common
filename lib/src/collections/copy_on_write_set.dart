part of restlib.common.collections;

class CopyOnWriteSetBuilder<E> {
  final MutableSet<E> _set = new MutableSet.hash();
  
  void add(final E element) =>
      _set.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _set.addAll(elements);
  
  ImmutableSet<E> build() => 
      new _CopyOnWriteSet(
          new MutableSet.hash(elements: _set));
}

class _CopyOnWriteSet<E> 
    extends _ImmutableSetBase<E> {
  final MutableSet<E> delegate;
  
  _CopyOnWriteSet(this.delegate);
  
}