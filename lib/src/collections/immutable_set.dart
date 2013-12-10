part of restlib.common.collections;

abstract class ImmutableSet<E> extends ImmutableCollection<E> implements FiniteSet<E>{
  static const ImmutableSet EMPTY = 
      const _PersistentSetBase._internal(
          ImmutableDictionary.EMPTY);
  
  factory ImmutableSet.from(Iterable<E> elements) =>
    (elements is _PersistentSetBase) ? elements :
      elements.fold(EMPTY, (final _PersistentSetBase<E> accumulator, final E element) => 
          accumulator.add(element));
  
  ImmutableSet<E> add(E value);
  ImmutableSet<E> addAll(Iterable<E> elements);
  ImmutableSet<E> remove(E element);
  

  ImmutableSet<E> difference(FiniteSet<E> other);
  ImmutableSet<E> intersection(FiniteSet<Object> other);
  ImmutableSet<E> union(FiniteSet<E> other);
}

abstract class _ImmutableSetBase<E> extends IterableBase<E> implements ImmutableSet<E> {
  const _ImmutableSetBase();
  
  int get hashCode =>
      computeHashCode(this);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSet) {
      if (this.length == other.length) {
        return every((final E element) => 
            other.contains(element));
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  
  
  String toString() =>
      "[" + join(", ") + "]";
}