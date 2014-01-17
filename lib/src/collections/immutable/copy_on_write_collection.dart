part of restlib.common.collections.immutable;

abstract class CopyOnWriteCollectionBuilder<E> {
  void add(final E element);
  
  void addAll(final Iterable<E> elements);
  
  ImmutableCollection<E> build();
}