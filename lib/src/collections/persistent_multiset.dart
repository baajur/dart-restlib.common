part of restlib.common.collections;

abstract class PersistentMultiset<E> implements PersistentCollection<E>, Multiset<E> {
  PersistentMultiset<E> add(E value);
  
  PersistentMultiset<E> addAll(Iterable<E> elements);  
  
  PersistentMultiset<E> remove(E element);
}