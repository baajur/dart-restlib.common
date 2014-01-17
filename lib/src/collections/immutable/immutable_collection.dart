part of restlib.common.collections.immutable;

abstract class ImmutableCollection<E> implements Iterable<E> {
  ImmutableCollection<E> add(E value);
  
  ImmutableCollection<E> addAll(Iterable<E> elements);  
  
  ImmutableCollection<E> remove(E element);
}