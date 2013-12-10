part of restlib.common.collections;

class CopyOnWriteMultisetBuilder<E> {
  final MutableMultiset<E> _set = new MutableMultiset.hash();
  
  void add(final E element) =>
      _set.add(element);
  
  void addAll(final Iterable<E> elements) =>
      _set.addAll(elements);
  
  ImmutableSet<E> build() => 
      new _CopyOnWriteSet(
          new MutableSet.hash(elements: _set));
}

class _CopyOnWriteMultiset<E> 
    extends _ImmutableMultisetBase<E> {
  final MutableMultiset<E> delegate;
  
  _CopyOnWriteMultiset(this.delegate);

}