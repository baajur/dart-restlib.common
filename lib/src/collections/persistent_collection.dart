part of restlib.common.collections;

abstract class PersistentCollection<E> implements Iterable<E>, Immutable {
  PersistentCollection<E> add(E value);
  
  PersistentCollection<E> addAll(Iterable<E> elements);  
  
  PersistentCollection<E> remove(E element);
}