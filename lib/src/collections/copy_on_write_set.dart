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
    extends _ImmutableSetBase<E>
    implements CopyOnWrite {
  final MutableSet<E> delegate;
  
  _CopyOnWriteSet(this.delegate);
  
  Iterator<E> get iterator =>
      delegate.iterator;
  
  ImmutableSet add(E element) =>
      new _CopyOnWriteSet(
          new MutableSet.hash()
            ..addAll(this)
            ..add(element));
  
  ImmutableSet addAll(Iterable<E> elements) =>
      new _CopyOnWriteSet(
          new MutableSet.hash()
            ..addAll(this)
            ..addAll(elements));
  
  ImmutableSet<E> difference(FiniteSet<E> other) =>
      new _CopyOnWriteSet(
          new MutableSet.hash(elements: this.where((final E element) => 
              !other.contains(element))));
  
  ImmutableSet<E> intersection(FiniteSet<Object> other) =>
      new _CopyOnWriteSet(
          new MutableSet.hash(elements: this.where((final E element) => 
              other.contains(element))));
    
  ImmutableSet<E> union(FiniteSet<E> other) =>
      new _CopyOnWriteSet(
          new MutableSet.hash()
            ..addAll(this)
            ..addAll(other));
  
  ImmutableSet remove(E element) =>
      new _CopyOnWriteSet(
          new MutableSet.hash()
            ..addAll(this)
            ..remove(element));
}