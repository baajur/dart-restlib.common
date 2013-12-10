part of restlib.common.collections;

abstract class ImmutableMultiset<E> implements ImmutableCollection<E>, Multiset<E> {
  static const ImmutableMultiset EMPTY = const _PersistentMultisetBase(ImmutableDictionary.EMPTY);
  
  ImmutableMultiset<E> add(E value);
  
  ImmutableMultiset<E> addAll(Iterable<E> elements);  
  
  ImmutableMultiset<E> remove(E element);
  
  ImmutableMultiset<E> removeAll(final E element);
}


abstract class _ImmutableMultisetBase<E> extends IterableBase<E> implements ImmutableMultiset<E> {
  const _ImmutableMultisetBase();
  
  bool operator==(other) {
    if (identical(this,other)) {
      return true;
    } else if (other is ImmutableMultiset) {
      // FIXME:
    } else {
      return false;
    }
  }
}