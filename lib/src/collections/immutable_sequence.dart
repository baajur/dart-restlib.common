part of restlib.common.collections;

abstract class ImmutableSequence<E> implements Sequence<E>, ImmutableCollection<E>, ImmutableStack<E>, ImmutableAssociative<int, E> {    
  int get hashCode;
  
  bool operator==(other);
  
  ImmutableSequence<E> add(E value);
  
  ImmutableSequence<E> addAll(Iterable<E> elements);  
  
  ImmutableSequence<E> remove(E element);
  
  ImmutableSequence<E> get tail;    
  
  ImmutableSequence<E> push(E value);
  
  ImmutableSequence<E> insertAll(final Iterable<Pair<int, E>> other);
  
  ImmutableSequence<E> insert(final int key, final E value);
  
  ImmutableSequence<E> insertPair(final Pair<int,E> pair);
  
  ImmutableSequence<E> removeAt(final int key);
}

abstract class _ImmutableSequenceBase<E> extends _SequenceBase<E> implements ImmutableSequence<E> {
  const _ImmutableSequenceBase();
  
  int get hashCode =>
      computeHashCode(this);
  
  bool operator==(other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ImmutableSequence) {
      return equal(this, other);
    } else {
      return false;
    }
  }
  
  ImmutableSequence<E> insertPair(final Pair<int,E> pair) =>
      insert(pair.fst, pair.snd);  
 
  ImmutableSequence<E> push(final E element) =>
      add(element);
  
  ImmutableSequence<E> pushAll(final Iterable<E> elements) =>
      addAll(elements);
  
  ImmutableSequence<E> remove(final E element) =>
      removeAt(indexOf(element));

}