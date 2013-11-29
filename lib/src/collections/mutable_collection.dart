part of restlib.common.collections;

abstract class MutableCollection<E> extends Iterable<E> {
  void add(E value);
  
  void addAll(Iterable<E> elements);  
  
  void clear();
  
  Option<E> remove(E element);
}